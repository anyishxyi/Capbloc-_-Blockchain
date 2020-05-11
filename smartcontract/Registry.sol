pragma solidity ^0.5.0;

contract Registry {
    
    struct society {
        uint256 id;
        string name;
        string capital;
        associeted[] associeted_member;
    }
    
    struct associeted {
        uint256 id;
        string last_name;
        string first_name;
        string address;
        uint256 action;
        associeted_type: types;
        string email;
    }
    
    enum associeted_type {
        associeted, other
    }
    
    
    
     constructor() public {
    }
    
    
}
