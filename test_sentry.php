<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once 'vendor/autoload.php';

\Sentry\init([
  'dsn' => 'https://9f7a12a5c9f8e205f5994a094df10367@o4507933327491072.ingest.de.sentry.io/4507938674049105',
  'traces_sample_rate' => 1.0,
  'profiles_sample_rate' => 1.0,
]);

try {
    // Error calling an undefined function
    $this->functionFailsForSure();
} catch (\Throwable $exception) {
    \Sentry\captureException($exception);
}

try {
    $a = 1 / 0; 
    undefinedFunction(); 
    throw new \Exception("This is a test exception for Sentry!"); 
} catch (\Throwable $exception) {
    \Sentry\captureException($exception);
}

echo "Test script executed.";
?>
