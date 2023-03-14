# Static HTTP server

* Respond to `GET` with status code in `{200,404,403}`
* Respond to `HEAD` with status code in `{200,404,403}`
* Respond to all other request methods with status code `405`
* Directory index file name `index.html`
* Respond to requests for `/<file>.html` with the contents of `DOCUMENT_ROOT/<file>.html`
* Requests for `/<directory>/` should be interpreted as requests for `DOCUMENT_ROOT/<directory>/index.html`
* Respond with the following header fields for all requests:
  * `Server`
  * `Date`
  * `Connection`
* Respond with the following additional header fields for all `200` responses to `GET` and `HEAD` requests:
  * `Content-Length`
  * `Content-Type`
* Respond with correct `Content-Type` for `.html, .css, js, jpg, .jpeg, .png, .gif, .swf`
* Respond to percent-encoding URLs
* Correctly serve a 2GB+ files
* No security vulnerabilities

---------------------------
# Build docker containers

```
docker build -t server -f Dockerfile .
docker run -p 8080:8080 server
```

```
docker build -t nginx -f nginx.Dockerfile .
docker run -p 9090:9090 nginx
```

# Checking the use of all cores
All cores are used. Use ```ps -mo pid,tid,%cpu,psr -p `pgrep python` ``` while program running.
<details><summary>Ran on 4-cores system<br>
(click to see all)</summary>
  <code>
  PID   TID %CPU PSR<br>
 8629     -  0.0   -<br>
    -  8629  0.0   1<br>
 8651     -  0.0   -<br>
    -  8651  0.0   2<br>
    -  8653  0.0   3<br>
 8652     -  0.0   -<br>
    -  8652  0.0   3<br>
    -  8655  0.0   0<br>
 8654     -  0.0   -<br>
    -  8654  0.0   2<br>
    -  8657  0.0   2<br>
 8656     -  0.0   -<br>
    -  8656  0.0   3<br>
    -  8658  0.0   1<br>
  </code>
</details>

--------------------------
# Functional testing
### `python3 httptest.py`
<details><summary>Ran 24 tests in 0.212s - OK<br>
(click to see all)</summary>
  <code>

    test_directory_index (__main__.HttpServer)
    directory index file exists ... ok
    test_document_root_escaping (__main__.HttpServer)
    document root escaping forbidden ... ok
    test_empty_request (__main__.HttpServer)
    Send empty line ... ok
    test_file_in_nested_folders (__main__.HttpServer)
    file located in nested folders ... ok
    test_file_not_found (__main__.HttpServer)
    absent file returns 404 ... ok
    test_file_type_css (__main__.HttpServer)
    Content-Type for .css ... ok
    test_file_type_gif (__main__.HttpServer)
    Content-Type for .gif ... ok
    test_file_type_html (__main__.HttpServer)
    Content-Type for .html ... ok
    test_file_type_jpeg (__main__.HttpServer)
    Content-Type for .jpeg ... ok
    test_file_type_jpg (__main__.HttpServer)
    Content-Type for .jpg ... ok
    test_file_type_js (__main__.HttpServer)
    Content-Type for .js ... ok
    test_file_type_png (__main__.HttpServer)
    Content-Type for .png ... ok
    test_file_type_swf (__main__.HttpServer)
    Content-Type for .swf ... ok
    test_file_urlencoded (__main__.HttpServer)
    urlencoded filename ... ok
    test_file_with_dot_in_name (__main__.HttpServer)
    file with two dots in name ... ok
    test_file_with_query_string (__main__.HttpServer)
    query string with get params ... ok
    test_file_with_slash_after_filename (__main__.HttpServer)
    slash after filename ... ok
    test_file_with_spaces (__main__.HttpServer)
    filename with spaces ... ok
    test_head_method (__main__.HttpServer)
    head method support ... ok
    test_index_not_found (__main__.HttpServer)
    directory index file absent ... ok
    test_large_file (__main__.HttpServer)
    large file downloaded correctly ... ok
    test_post_method (__main__.HttpServer)
    post method forbidden ... ok
    test_request_without_two_newlines (__main__.HttpServer)
    Send GET without to newlines ... ok
    test_server_header (__main__.HttpServer)
    Server header exists ... ok

    ----------------------------------------------------------------------
    Ran 24 tests in 0.212s

    OK
  </code>
</details>
