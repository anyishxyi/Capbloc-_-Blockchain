const forbiddenError = errorMessage => {
    return {
        status: 403,
        title: 'Forbidden Error',
        detail: errorMessage
    };
};

export default forbiddenError;
