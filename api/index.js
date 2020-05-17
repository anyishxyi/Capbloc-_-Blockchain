import express from 'express';
import bodyParser from 'body-parser';
import cookieParser from 'cookie-parser';
import logger from 'morgan';
import cors from 'cors';
import { smartContractRouter } from './src/routes';

const app = express();

app.use(cors());
if (process.env.NODE_ENV !== 'test') {
    app.use(logger('combined'));
}
app.use(bodyParser.json({limit: '50mb', extended: true}));
app.use(bodyParser.urlencoded({limit: '50mb', extended: false }));
app.use(cookieParser());

app.use('/api/v1/', smartContractRouter);
module.exports = app;
