// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/*
 * @author not-so-secure-dev
 * @title PasswordStore
 * @notice This contract allows you to store a private password that others won't be able to see.
 * You can update your password at any time.
 */
contract PasswordStore {
    // i maybe use better error naming convention
    error PasswordStore__NotOwner();

    address private s_owner;
    // @audit// the s_password variable is not actually private! this is not a safe place to secure your password
    string private s_password;

    event SetNetPassword();

    constructor() {
        s_owner = msg.sender;
    }

    // @audit-high, access control vunerability;

    function setPassword(string memory newPassword) external {
        s_password = newPassword;
        emit SetNetPassword();
    }

    /*
     * @notice This allows only the owner to retrieve the password.
     theres no newPassword parameter
     * @param newPassword The new password to set.
     */
    function getPassword() external view returns (string memory) {
        if (msg.sender != s_owner) {
            revert PasswordStore__NotOwner();
        }
        return s_password;
    }
}