import { contract, web3 } from "../../repository/connection";
import { generiqueReturn } from "../../interfaces/serialize/index";
import { badRequestError } from "../../interfaces/errors";


const addAssociate = async (req, res) => {
    try {
        const associate = req.body;
        const get_accounts = await web3.eth.getAccounts();
        const create_result = await contract.methods.add_associe(associate.token, associate.first_name, associate.last_name, associate.address_person, associate.part, associate.email, associate.name_society)
            .send({from: get_accounts[0], gas: 6000000})
        res.status(201).json(generiqueReturn({ data: create_result, status: res.statusCode }))
    } catch (error) {
        res.status(400).json(badRequestError(error.toString()))
        console.error(error)
    }
};

export default addAssociate;