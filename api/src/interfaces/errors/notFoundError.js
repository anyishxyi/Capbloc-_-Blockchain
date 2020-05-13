const notFoundError = errorMessage => {
    return {
        status: 404,
        title: 'Not Found',
        detail: errorMessage
    };
};

export default notFoundError;
