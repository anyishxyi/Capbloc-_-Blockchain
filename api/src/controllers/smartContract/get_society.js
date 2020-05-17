import { contract, web3 } from "../../repository/connection";
import { generiqueReturn } from "../../interfaces/serialize/index";
import { badRequestError } from "../../interfaces/errors";

const get_society = async (req, res) => {
    try {
        const society = await contract.methods.get_society(req.query.name_society).call();
        res.status(200).json(generiqueReturn({ data: society, status: res.statusCode }));
    } catch (error) {
        res.status(400).json(badRequestError(error.toString()))
        console.error(error)
    }
}

export default get_society;