import { contract, web3 } from "../../repository/connection";
import { generiqueReturn } from "../../interfaces/serialize/index";
import { badRequestError } from "../../interfaces/errors";


const create_society = async (req, res) => {
    try {
        const society = req.body;
        const get_accounts = await web3.eth.getAccounts();
        const create_result = await contract.methods.create_society(society.name, society.capital)
            .send({from: get_accounts[0]})
        res.status(201).json(generiqueReturn({ data: create_result, status: res.statusCode }))
    } catch (error) {
        res.status(400).json(badRequestError(error.toString()))
        console.error(error)
    }
};

export default create_society;