import express from 'express';

import { 
    test,
    create_society,
    get_society,
    balanceOf,
    addAssociate,
    giveTo
} from '../controllers/smartContract';

const router = express.Router();

router.get('/', test);
router.get('/society', get_society);
router.get('/balanceOf', balanceOf);
router.get('/getToken', getToken); // to validate

router.post('/create_society', create_society);
router.post('/addAssociate', addAssociate);
router.post('/giveTo', giveTo);


export default router;
