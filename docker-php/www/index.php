<?php

// Test mails (check with mailhog)
if (!mail('user@test.com', 'Test', 'Mail test', 'From: webmaster@test.com')) {
    print_r(error_get_last()['message']);
}

// Test write permissions (check in this file's folder)
if (!file_put_contents('write_test.txt', 'test')) {
    print_r(error_get_last()['message']);
}

// Show php informations
phpinfo();

?>
