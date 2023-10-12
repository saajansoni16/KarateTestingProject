function fn() {
    var config = {
        author: 'Saajan Soni'
    };

    karate.configure('connectTimeout', 5000);
    karate.configure('readTimeout', 5000);
    return config;
}