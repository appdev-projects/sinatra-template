# sinatra-banking-app Functional Specification
The application provides users with a graphical user interface to perform basic bank account management functions.

## User Stories

### Basic Operations
- As a user, I want to make a deposit to my account, so that I can make a credit on the account.
- As a user, I want to make a withdrawal from my account, so that I make a debit on the account.
- As a user, I want to have the capability to open an account.
- As a user, I want to have the capability to close my account.
- As a user, I want to have the capability to view my account balance.

### Continuous Operations
- As a user, I want to perform multiple transactions without restarting the application, so that I can use the application more efficiently.

## Functional Requirements
- The application must prompt the user for a banking operation ( deposit/withdraw )
- The application must prompt the user for an account number.
- The application must display the result of the operation.
- The application must handle invalid input gracefully (e.g., non-numeric input).
- The application must allow the user to perform another transaction after one completes.
