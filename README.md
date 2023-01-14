# payhere
### [페이히어] Python 백엔드 엔지니어 과제 (가계부)
- 프레임워크 : Django(DRF)
- DB : mysql:5.7
- 개발 기간 : 23-01-11 ~ 23-01-14 (4일)

# 와이어프레임								
![image](https://user-images.githubusercontent.com/113074274/212457417-a61aeb2a-5f2d-427a-bf7d-1e0245469b6e.png)



- 가계부와 같이 날짜, 수입, 지출, 잔액, 메모를 사용할 수 있게 설계하였습니다.
- 수입 또는 지출이 일어날 시 잔액에 바로 반영될 수 있도록 설계하였습니다.
- 가계부 기록 중간에 새로운 내용을 삽입 하더라도 잔액이 변경되어 남은 잔액이 얼마나 남았는지 확인 할 수 있도록 설계하였습니다.

# ERD
![image](https://user-images.githubusercontent.com/113074274/212456742-04e11dcc-b764-44ae-b3ba-39c38eb522a1.png)


# API

| 기능 | Method | URL | 비고 |
| --- | --- | --- | --- |
| 회원가입 | POST | /users/signup/ |  |
| 로그인 | POST | /users/api/token/ |  |
| 로그아웃 | POST | /users/api/token/blacklist/ | 로그아웃 기능으로서 아직 부족 |
| --- | --- | --- | --- | --- | --- |
| 가계부 기록 | POST | /account_books/<int:author_id>/ |  |
| 가계부 기록 리스트 | GET | /account_books/<int:author_id>/ |  |
| 가계부 기록 상세 | GET | /account_books/<int:author_id>/<int:account_book_id>/ |  |
| 가계부 기록 수정 | PUT | /account_books/<int:author_id>/<int:account_book_id>/ |  |
| 가계부 기록 복제 | PUT | /account_books/<int:author_id>/<int:account_book_id>/ | {"is_copy":"true"} |
| 가계부 기록 삭제 | DELETE | /account_books/<int:author_id>/<int:account_book_id>/ |  |
| --- | --- | --- | --- | --- | --- |
| 단축 URL 생성 | POST | /account_books/create_url/ |  |
| 단축 URL 접속 | POST | /<new_url>/ |  |

# 요구사항
1. 고객은 이메일과 비밀번호 입력을 통해서 회원 가입을 할 수 있습니다. 
    - 커스텀 유저를 통하여 이메일이 아이디가 될 수 있도록 구현 하였습니다.
2. 고객은 회원 가입이후, 로그인과 로그아웃을 할 수 있습니다. 
    - jwt token을 이용하여 로그인을 구현 하였습니다.
    - blacklist를 이용하여 구현하였지만 보완이 필요합니다.
    
3. 고객은 로그인 이후 가계부 관련 아래의 행동을 할 수 있습니다. 

    1. 가계부에 오늘 사용한 돈의 금액과 관련된 메모를 남길 수 있습니다. 
        - income(수입), expenses(지출), balance(잔액), content(메모)를 기입할 수 있습니다.
        - 수입이나 지출 금액은 default 값을 0으로 지정하여 원하는 값만 입력하게 하였습니다.
        
    2. 가계부에서 수정을 원하는 내역은 금액과 메모를 수정 할 수 있습니다. 
        - 원하는 정보만 수정하고 수정하지 않은 사항은 기존 값을 유지할 수 있게 하였습니다.
        
    3. 가계부에서 삭제를 원하는 내역은 삭제 할 수 있습니다. 
        - 영구 삭제 방식으로 구현하였습니다.
    
    4. 가계부에서 이제까지 기록한 가계부 리스트를 볼 수 있습니다.
        - 리스트 마다 수입, 지출, 현재 잔액, 메모를 확인할 수 있습니다.
        - 모든 리스트를 불러와서 현재 잔액을 변동하여 기록을 불러올 때 시간이 너무 많이 소요되어 코드를 개선하였습니다.
            - update_balance 변수를 생성하고, 변경된 balance 값만 update_balance로 append 하여 bulk_update 시간을 줄여보았습니다.
            - get_balnace()의 else문으로 인해 balance 업데이트 값 변동이 안되는 것을 확인하여 주석처리하였습니다.
        
        ```python
        class AccountBooksSerializer(serializers.ModelSerializer):
            account_books = AccountBooks
            balance = serializers.SerializerMethodField()

            def get_balance(self, obj):
                account_books = AccountBooks.objects.filter(author_id=obj.author.id)
                balance = 0
                update_balance =[]
                for account_book in account_books:
                    if obj.date >= account_book.date and obj.created_at>= account_book.created_at:
                        balance += account_book.income - account_book.expenses
                        if account_book.balance != balance:
                            account_book.balance = balance
                            update_balance.append(account_book)
                   # else:
                   #     break
                AccountBooks.objects.bulk_update(update_balance,["balance"])
                return balance
        ```
        
    5. 가계부에서 상세한 세부 내역을 볼 수 있습니다. 
        - 수입, 지출, 현재 잔액, 메모를 확인할 수 있습니다.
        
    6. 가계부의 세부 내역을 복제할 수 있습니다.
        - 원하는 상세 세부 내역을 복사할 수 있습니다
        
    7. 가계부의 특정 세부 내역을 공유할 수 있게 단축 URL을 만들 수 있습니다.
    (단축 URL은 특정 시간 뒤에 만료되어야 합니다.)
        - base62 방식으로 랜덤으로 8자리의 url을 생성합니다.
        - datetime을 이용하여 단축 url 생성 시간과 비교하여 일정 시간이 지나면 해당 단축 url을 삭제합니다.
        - 비로그인 사용자는 해당 단축 url 주소를 알아도 접근 할 수 없습니다.

로그인하지 않은 고객은 가계부 내역에 대한 접근 제한 처리가 되어야 합니다.

# 테스트 코드
 각 url의 method에 대하여 테스트 코드를 간단히 작성하였습니다.
