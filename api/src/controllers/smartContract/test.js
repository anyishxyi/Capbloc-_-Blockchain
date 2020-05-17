import { contract, web3 } from "../../repository/connection";
import { generiqueReturn } from "../../interfaces/serialize/index";
import { badRequestError } from "../../interfaces/errors";

const test = async (req, res) => {
        res.status(200).json(generiqueReturn({ data: "Polo test", status: res.statusCode }))
};

export default test;
