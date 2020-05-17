import express from 'express';

import { 
    test,
    create_society,
    get_society,
    balanceOf
} from '../controllers/smartContract';

const router = express.Router();

router.get('/', test);
router.post('/create_society', create_society);
router.get('/society', get_society);
router.get('/balanceOf', balanceOf);

export default router;