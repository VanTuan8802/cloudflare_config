# cloudflare_config

Remote config cho các app, chạy trên Cloudflare Worker + KV.

- `GET /config/<appId>?env=dev|prod&version=<build>`
- Mỗi app một thư mục `apps/<appId>/`: `app.json` (`newFromVersion`), `dev.old|new.json`, `prod.old|new.json`
- Cập nhật config: `./push.sh <appId>` (không cần deploy lại)
- Deploy Worker: `npx wrangler deploy`
- Kiểm tra: `./test.sh`
