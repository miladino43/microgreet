##!/bin/bash

_HTTP_CODE_=$(curl -s -w "%{http_code}"  http://localhost:8000)

[ "${_HTTP_CODE_}" == "200" ] ||  { echo "Greetings healthcheck returning $_HTTP_CODE_" ; exit 1; }

exit 0;


