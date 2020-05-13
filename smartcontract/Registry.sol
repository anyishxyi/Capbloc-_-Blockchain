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
        string person;
        nantises[] nantises_member;
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
    
    struct nantises {
        string[] person;
        string[] guarenties;
        uint256[] id;
    }

    enum associeted_type {associeted, other}

    mapping(string => societies) society;
    mapping(string => associeted) associe;
    mapping(string => nantises) nantise;

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
        returns (string memory, uint256, uint256, associeted[] memory, nantises[] memory)
    {
        uint256 max_length = get_all_associeted(name).length;
        uint nantises_quantity = get_nantises_length(name);
        societies storage _societies = society[name];
        associeted[] memory associet = new associeted[](max_length);
        nantises[] memory nantis = new nantises[](nantises_quantity);
        for (uint256 i = 0; i < max_length; i++) {
            associet[i] = _societies.associeted_member[i];
            nantis[i] = _societies.nantises_member[i];
        }
        return (_societies.name, _societies.capital, _societies.id, associet, nantis);
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
        uint256 timeNow = block.timestamp;
        _associeted.id = timeNow;
        _societies.associeted_member.push(_associeted);
    }

    function del_all_associe(string memory name_society) public {
        societies storage _societies = society[name_society];
        _societies.associeted_member.pop();
        // return _societies.associeted_member;
    }

    function get_associe(string memory email, string memory name_society)
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
        uint256 id_user = _associeted.id;
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
            associet[index].action,
            associet[index].email
        );
    }
    
    function create_nantises(string memory person, string memory guarenties, string memory name_society) public returns (bool){
        nantises storage _nantises = nantise[person];
        societies storage _societies = society[name_society];
        associeted storage _associeted = associe[person];
         bytes memory temp_associeted_email = bytes(_associeted.email);
        if (temp_associeted_email.length == 0) {
           return false;
        }
        
        _nantises.person.push(person);
        _nantises.guarenties.push(guarenties);
        uint256 timeNow = block.timestamp;
        _nantises.id.push(timeNow);
        _societies.nantises_member.push(_nantises);
        // _nantises.id = id;
        
        return true;
    }
    
    
    function get_nantises(string memory person) public view returns (string[] memory, string[] memory, uint256[] memory) {
        nantises storage _nantises = nantise[person];
        uint nantises_quantity = get_nantises_length(person);
        string[] memory persons = new string[](nantises_quantity);
        string[] memory guarenties = new string[](nantises_quantity);
        uint256[] memory id = new uint256[](nantises_quantity);
        for (uint256 i = 0; i < nantises_quantity; i++) {
            persons[i] = _nantises.person[i];   
            guarenties[i] = _nantises.guarenties[i];  
            id[i] = _nantises.id[i];
            /*if (StringUtils.equal(_nantises.person[i], person)) {
             person[i] = _nantises.person[i];   
            }*/
        }
         return (
            guarenties,
            persons,
            id
        );
        
    }
    
    function get_nantises_length(string memory person) public view returns (uint) {
         nantises storage _nantises = nantise[person];
         return _nantises.person.length;
         
    }
    
    function updaate_nantises(uint256 id, string memory person, string memory guarenties) public returns (bool) {
        nantises storage _nantises = nantise[person];
        uint nantises_quantity = get_nantises_length(person);
        uint256 index;
         for (uint256 i = 0; i < nantises_quantity; i++) { 
             if(id == _nantises.id[i]) {
                 index = i;
             }
         }
         _nantises.person[index] = person;
         _nantises.guarenties[index] = guarenties;
         
        // string memory person_to_update =
        return true;
    }
    
    
}
