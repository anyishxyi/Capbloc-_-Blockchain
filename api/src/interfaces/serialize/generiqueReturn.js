import _ from "lodash";

const generiqueReturn = ({ data, status }) => {

    return {
        data: _.isArray(data) ? data : [data],
        total: _.isArray(data) ? data.lenght : _.isEmpty(data) ? 0 : 1,
        status
    };
};

export default generiqueReturn;
