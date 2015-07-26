# Perish API
***
### Upload a File
#### Request
```bash
curl -F "document=@/home/marvin/Downloads/test.mp3;type=audio/mp3" https://perish-api.herokuapp.com/perishables
```
#### Response
```json
{
    "name":"test.mp3",
    "content_type":"audio/mp3",
    "size":"7.91 MB",
    "digest":"dc6c91137119de341c569242c0f70af4148a46c8d73174f3c0fa9befd5352b47",
    "url":"https://perish-api.herokuapp.com/perishables/dc6c91137119de341c569242c0f70af4148a46c8d73174f3c0fa9befd5352b47",
    "download_url":"https://perish-api.herokuapp.com/perishables/dc6c91137119de341c569242c0f70af4148a46c8d73174f3c0fa9befd5352b47/download",
    "key":"18b3579d0e06edbf740658169a6f8aebea4d4da149d587a71fdb1a1d491cd601",
    "iv":"88d64b96384ebcc371a5aaf0951069a9"
}
```
***
### Get File Info
#### Request
```bash
curl https://perish-api.herokuapp.com/perishables/dc6c91137119de341c569242c0f70af4148a46c8d73174f3c0fa9befd5352b47
```
#### Response
```json
{
    "name":"test.mp3",
    "content_type":"audio/mp3",
    "size":"7.91 MB",
    "digest":"dc6c91137119de341c569242c0f70af4148a46c8d73174f3c0fa9befd5352b47",
    "url":"https://perish-api.herokuapp.com/perishables/dc6c91137119de341c569242c0f70af4148a46c8d73174f3c0fa9befd5352b47",
    "download_url":"https://perish-api.herokuapp.com/perishables/dc6c91137119de341c569242c0f70af4148a46c8d73174f3c0fa9befd5352b47/download"
}
```
***
### Download File
#### Request
```bash
curl -F key=18b3579d0e06edbf740658169a6f8aebea4d4da149d587a71fdb1a1d491cd601 -F iv=88d64b96384ebcc371a5aaf0951069a9 https://perish-api.herokuapp.com/perishables/dc6c91137119de341c569242c0f70af4148a46c8d73174f3c0fa9befd5352b47/download > received.mp3
```
#### Response
The raw file data.