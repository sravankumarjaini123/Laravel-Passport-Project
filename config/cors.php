<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Cross-Origin Resource Sharing (CORS) Configuration
    |--------------------------------------------------------------------------
    |
    | Here you may configure your settings for cross-origin resource sharing
    | or "CORS". This determines what cross-origin operations may execute
    | in web browsers. You are free to adjust these settings as needed.
    |
    | To learn more: https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
    |
    */

    'paths' => ['api/*', 'sanctum/csrf-cookie'], //Defines which routes CORS should apply to.So CORS will apply only to these routes.

    'allowed_methods' => ['*'], //Specifies which HTTP methods are allowed from frontend.GET POST PUT PATCH DELETE OPTIONS
//Production Example:'allowed_methods' => ['GET', 'POST'],
    'allowed_origins' => ['*'], //Defines which frontend domains can access your API. 'http://localhost:3000','https://yourdomain.com'

    'allowed_origins_patterns' => [], //Used when you want to allow subdomains.'allowed_origins_patterns' => ['*.yourdomain.com'],

//     app.yourdomain.com
// admin.yourdomain.com
// api.yourdomain.com

    'allowed_headers' => ['*'], //Defines which HTTP headers are allowed from frontend.Authorization,Content-Type,Accept,X-Requested-With

    'exposed_headers' => [], //Defines which HTTP headers are allowed to be sent to the frontend.'exposed_headers' => ['Authorization'],

    'max_age' => 0, //The maximum number of seconds a browser should cache the CORS preflight response.
    //Browser sends a Preflight OPTIONS request before actual request.How long browser should cache CORS permission
    //'max_age' => 3600,Browser won’t send OPTIONS request again for 1 hour.Improves performance

    'supports_credentials' => false,

];
