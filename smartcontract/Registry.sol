pragma solidity ^0.5.0;

pragma experimental ABIEncoderV2;


contract Registry {
    uint8 private _decimals;
    string private _symbol;
    string private _name;

    struct societies {
        uint256 id;
        string name;
        uint256 capital;
        associeted[] associeted_member;
    }

    struct associeted {
        uint256 id;
        string last_name;
        string first_name;
        string address_person;
        uint256 action;
        associeted_type types;
        string email;
    }

    enum associeted_type {associeted, other}

    mapping(string => societies) society;
    mapping(string => associeted) associe;

    constructor() public {
        _name = "TST";
        _symbol = "TST";
        _decimals = 2;
    }

    function create_society(string memory name, uint256 capital) public {
        societies storage _societies = society[name];
        _societies.name = name;
        _societies.capital = capital;
        uint256 timeNow = block.timestamp;
        _societies.id = timeNow;
    }

    function get_society(string memory name)
        public
        view
        returns (string memory, uint256, uint256, associeted[] memory)
    {
        uint256 max_length = get_all_associeted(name).length;
        societies storage _societies = society[name];
        associeted[] memory associet = new associeted[](max_length);
        for (uint256 i = 0; i < max_length; i++) {
            associet[i] = _societies.associeted_member[i];
        }
        return (_societies.name, _societies.capital, _societies.id, associet);
    }

    function get_all_associeted(string memory name)
        public
        view
        returns (associeted[] memory)
    {
        societies storage _societies = society[name];
        return _societies.associeted_member;
    }

    function add_update_associe(
        string memory first_name,
        string memory last_name,
        string memory address_person,
        uint256 action,
        string memory email,
        string memory name_society
    ) public {
        associeted storage _associeted = associe[email];
        societies storage _societies = society[name_society];

        _associeted.first_name = first_name;
        _associeted.last_name = last_name;
        _associeted.address_person = address_person;
        _associeted.action = action;
        _associeted.email = email;
        // require(uint(associeted_type.associeted) >= types);
        // _associeted.associeted_type = _associeted_type;
        // _associeted.id = substring();
        _societies.associeted_member.push(_associeted);
    }

    function del_associe(string memory name_society) public {
        societies storage _societies = society[name_society];
        _societies.associeted_member.pop();
        // return _societies.associeted_member;
    }

    function get_associe(string memory email)
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            uint256,
            string memory
        )
    {
        associeted storage _associeted = associe[email];
        return (
            _associeted.first_name,
            _associeted.last_name,
            _associeted.address_person,
            _associeted.action,
            _associeted.email
        );
    }
}
