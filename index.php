<?php

if ($_SERVER['REQUEST_URI'] === '/') {
    echo "Hello v2.0.1 ", getenv('NETWORK_REGION');
    return;
}

header("HTTP/1.0 404 Not Found");
?>