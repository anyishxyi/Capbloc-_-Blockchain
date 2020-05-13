const unauthorizedError = errorMessage => {
    return {
        status: 401,
        title: 'Unauthorized',
        detail: errorMessage
    };
};

export default unauthorizedError;
