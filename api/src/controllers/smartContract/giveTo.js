import { contract, web3 } from "../../repository/connection";
import { generiqueReturn } from "../../interfaces/serialize/index";
import { badRequestError } from "../../interfaces/errors";


const giveTo = async (req, res) => {
    try {
        const data = req.body;
        const get_accounts = await web3.eth.getAccounts();
        const create_result = await contract.methods.give_to(data.token_recev, data.part_recev, data.name_society)
            .send({from: get_accounts[0], gas: 6000000})
        res.status(201).json(generiqueReturn({ data: create_result, status: res.statusCode }))
    } catch (error) {
        res.status(400).json(badRequestError(error.toString()))
        console.error(error)
    }
};

export default giveTo;