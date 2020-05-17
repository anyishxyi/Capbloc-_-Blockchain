const badRequestError = errorMessage => {
    return {
        status: 400,
        title: 'Bad Request',
        detail: errorMessage
    };
};

export default badRequestError;
