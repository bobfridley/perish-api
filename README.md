# Perish API

### Upload a File [POST http://api.perish.me/perishables]

#### Request
```bash
curl -F "document=@/home/marvin/Downloads/test.mp3;type=audio/mp3" http://api.perish.me/perishables
```

#### Response
```json
{
    "name": "perish.png",
    "content_type": "image/png",
    "size": "14.3 KB",
    "digest": "4xX-tWXrZtEbPmA5gj1vW0eTsQNdqbeH3nw9GOeqZT8=",
    "key": "5_duKCNg7_GOSX8Iv5PXcOybj22jxEaaNXEByLJxLeQ=",
    "iv": "tya3R1OouLJWv53AnyS1rQ==",
    "url": "http://api.perish.me/perishables/4xX-tWXrZtEbPmA5gj1vW0eTsQNdqbeH3nw9GOeqZT8=",
    "download_url": "http://api.perish.me/perishables/4xX-tWXrZtEbPmA5gj1vW0eTsQNdqbeH3nw9GOeqZT8=/download"
}
```

***

### Get File Info [GET http://api.perish.me/perishables/{digest}]

#### Request
```bash
curl http://api.perish.me/perishables/4xX-tWXrZtEbPmA5gj1vW0eTsQNdqbeH3nw9GOeqZT8=
```

#### Response
```json
{
    "name": "perish.png",
    "content_type": "image/png",
    "size": "14.3 KB",
    "digest": "4xX-tWXrZtEbPmA5gj1vW0eTsQNdqbeH3nw9GOeqZT8=",
    "url": "http://api.perish.me/perishables/4xX-tWXrZtEbPmA5gj1vW0eTsQNdqbeH3nw9GOeqZT8=",
    "download_url": "http://api.perish.me/perishables/4xX-tWXrZtEbPmA5gj1vW0eTsQNdqbeH3nw9GOeqZT8=/download"
}
```

***

### Delete File [DELETE http://api.perish.me/perishables/{digest}]

#### Request
```bash
curl -X DELETE http://api.perish.me/perishables/4xX-tWXrZtEbPmA5gj1vW0eTsQNdqbeH3nw9GOeqZT8=
```

#### Response
```json
{
    "name": "perish.png",
    "content_type": "image/png",
    "size": "14.3 KB",
    "digest": "4xX-tWXrZtEbPmA5gj1vW0eTsQNdqbeH3nw9GOeqZT8=",
}
```

***

### Download File [POST http://api.perish.me/perishables/{digest}/download]

#### Request
```bash
curl -F key=5_duKCNg7_GOSX8Iv5PXcOybj22jxEaaNXEByLJxLeQ= iv=tya3R1OouLJWv53AnyS1rQ== http://api.perish.me/perishables/4xX-tWXrZtEbPmA5gj1vW0eTsQNdqbeH3nw9GOeqZT8=/download > perish.png
```

#### Response
```
The raw file data.
```
