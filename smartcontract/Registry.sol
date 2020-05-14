pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

pragma experimental ABIEncoderV2;


contract Registry is ERC20 {
    uint8 private _decimals;
    string private _symbol;
    string private _name;

    struct societies {
        // uint256 id;
        string name;
        uint256 capital;
        //  uint256 start_capital;
        associeted[] associeted_member;
        // associeted creator;
        address create_by;
        // nantises[] nantises_member;
    }

    struct associeted {
        uint256 id;
        address token;
        string last_name;
        string first_name;
        string address_person;
        uint256 part;
        // associeted_type types;
        string email;
    }

    struct nantises {
        string[] person;
        string[] guarenties;
        uint256[] id;
    }

    enum associeted_type {associeted, other}

    mapping(string => societies) society;
    mapping(string => associeted) associe;
    mapping(address => associeted) token_associe;
    mapping(string => nantises) nantise;

    constructor() public ERC20("CAPI", "CAPI") {
        _name = "CAPI";
        _symbol = "CAPI";
        _decimals = 0;
        _setupDecimals(0);
    }

    function create_society(
        string memory name,
        uint256 capital,
        string memory last_name,
        string memory first_name,
        string memory address_person
    ) public {
        societies storage _societies = society[name];
        associeted storage _token_associe = token_associe[msg.sender];
        uint256 timeNow = block.timestamp;
        _societies.name = name;
        _societies.capital = capital;
        _token_associe.last_name = last_name;
        _token_associe.first_name = first_name;
        _token_associe.part = 100;
        _token_associe.token = msg.sender;
        _societies.create_by = msg.sender;
        _token_associe.address_person = address_person;
        _token_associe.id = timeNow;
        _societies.associeted_member.push(_token_associe);
        _mint(msg.sender, capital);
    }

    function get_society(string memory name)
        public
        view
        returns (string memory, uint256, associeted[] memory)
    {
        uint256 max_length = get_all_associeted(name).length;
        societies storage _societies = society[name];
        associeted[] memory associet = new associeted[](max_length);
        for (uint256 i = 0; i < max_length; i++) {
            associet[i] = _societies.associeted_member[i];
        }
        return (_societies.name, _societies.capital, associet);
    }

    function get_all_associeted(string memory name_society)
        public
        view
        returns (associeted[] memory)
    {
        societies storage _societies = society[name_society];
        return _societies.associeted_member;
    }

    function add_associe(
        address token,
        string memory first_name,
        string memory last_name,
        string memory address_person,
        uint256 part,
        string memory email,
        string memory name_society
    ) public {
        associeted storage _token_associe = token_associe[token];
        societies storage _societies = society[name_society];

        _token_associe.token = token;
        _token_associe.first_name = first_name;
        _token_associe.last_name = last_name;
        _token_associe.address_person = address_person;
        _token_associe.part = part;
        _token_associe.email = email;
        uint256 timeNow = block.timestamp;
        _token_associe.id = timeNow;
        uint256 amount = (_societies.capital * part) / 100;
        transfer(token, amount);

        _societies.associeted_member.push(_token_associe);
        set_part(token, name_society, part);
    }

    function del_all_associe(string memory name_society) public {
        societies storage _societies = society[name_society];
        _societies.associeted_member.pop();
    }

    function get_associe(address tokens, string memory name_society)
        public
        view
        returns (
            string memory first_name,
            string memory last_name,
            string memory address_person,
            uint256 part,
            string memory emails,
            address token
        )
    {
        associeted storage _token_associe = token_associe[tokens];
        uint256 id_user = _token_associe.id;
        societies storage _societies = society[name_society];
        uint256 max_length = get_all_associeted(name_society).length;
        uint256 index;
        associeted[] memory associet = new associeted[](max_length);
        for (uint256 i = 0; i < max_length; i++) {
            associet[i] = _societies.associeted_member[i];
        }
        for (uint256 j = 0; j < max_length; j++) {
            if (id_user == associet[j].id) {
                index = j;
            }
        }

        return (
            associet[index].first_name,
            associet[index].last_name,
            associet[index].address_person,
            associet[index].part,
            associet[index].email,
            associet[index].token
        );
    }

    function get_token(address tokens, string memory name_society)
        public
        view
        returns (address token)
    {
        associeted storage _token_associe = token_associe[tokens];
        uint256 id_user = _token_associe.id;
        societies storage _societies = society[name_society];
        uint256 max_length = get_all_associeted(name_society).length;
        uint256 index;
        associeted[] memory associet = new associeted[](max_length);
        for (uint256 i = 0; i < max_length; i++) {
            associet[i] = _societies.associeted_member[i];
        }
        for (uint256 j = 0; j < max_length; j++) {
            if (id_user == associet[j].id) {
                index = j;
            }
        }
        return (associet[index].token);
    }

    function get_part(address tokens, string memory name_society)
        public
        view
        returns (uint256 part)
    {
        associeted storage _token_associe = token_associe[tokens];
        uint256 id_user = _token_associe.id;
        societies storage _societies = society[name_society];
        uint256 max_length = get_all_associeted(name_society).length;
        uint256 index;
        associeted[] memory associet = new associeted[](max_length);
        for (uint256 i = 0; i < max_length; i++) {
            associet[i] = _societies.associeted_member[i];
        }
        for (uint256 j = 0; j < max_length; j++) {
            if (id_user == associet[j].id) {
                index = j;
            }
        }
        return (associet[index].part);
    }

    function set_part(address tokens, string memory name_society, uint256 part)
        public
    {
        associeted storage _token_associe = token_associe[tokens];
        associeted storage _token_giver = token_associe[msg.sender];
        uint256 id_user = _token_associe.id;
        uint256 id_giver = _token_giver.id;
        societies storage _societies = society[name_society];
        uint256 max_length = get_all_associeted(name_society).length;
        uint256 index;
        uint256 index_giver;
        associeted[] memory associet_search = new associeted[](max_length);
        for (uint256 i = 0; i < max_length; i++) {
            associet_search[i] = _societies.associeted_member[i];
        }
        for (uint256 j = 0; j < max_length; j++) {
            if (id_user == associet_search[j].id) {
                index = j;
            }
            if (id_giver == associet_search[j].id) {
                index_giver = j;
            }
        }
        uint256 giver = get_part(msg.sender, name_society) - part;
        _token_giver.part = giver;
        associet_search[index].part = associet_search[index].part + part;
        _societies.associeted_member[index].part = associet_search[index].part;
        _societies.associeted_member[index_giver].part = _token_giver.part;
    }

    function give_to_new_member(
        address token_recev,
        string memory first_name_recev,
        string memory last_name_recev,
        string memory address_person_recev,
        uint256 part_recev,
        string memory email_recev,
        string memory name_society
    ) public {
        add_associe(
            token_recev,
            first_name_recev,
            last_name_recev,
            address_person_recev,
            part_recev,
            email_recev,
            name_society
        );
        uint256 _actual_balance = balanceOf(msg.sender);
        uint256 amount = (_actual_balance * part_recev) / 100;
        transfer(token_recev, amount);
        set_part(token_recev, name_society, part_recev);
    }

    function get_capital(string memory name_society)
        public
        view
        returns (uint256 capital)
    {
        societies storage _societies = society[name_society];
        return _societies.capital;
    }

    function give_to(
        address token_recev,
        uint256 part_recev,
        string memory name_society
    ) public {
        uint256 _actual_balance = balanceOf(msg.sender);

        uint256 amount = (_actual_balance * part_recev) / 100;
        transfer(token_recev, amount);
        set_part(token_recev, name_society, part_recev);
    }
}
