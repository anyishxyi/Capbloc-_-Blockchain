import Web3 from 'web3';
const config = require('../../config.json');
const defaultConfig = config.development;
export const web3 = new Web3('http://127.0.0.1:8545');
export const contract = new web3.eth.Contract(defaultConfig.ABI, defaultConfig.hash);