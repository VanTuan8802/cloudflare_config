// GET /config/<appId>?env=dev|prod&version=<build>
// KV keys per app: <appId>:app ({newFromVersion}), <appId>:<dev|prod>.<old|new>
export default {
  async fetch(req, env) {
    const u = new URL(req.url);
    const m = u.pathname.match(/^\/config\/([\w.-]+)$/);
    if (!m) return new Response("not found", { status: 404 });
    const app = m[1];

    const meta = await env.CONFIG.get(`${app}:app`, "json");
    if (!meta) return new Response("unknown app", { status: 404 });

    const e = u.searchParams.get("env") === "dev" ? "dev" : "prod";
    const gen = (+u.searchParams.get("version") || 0) >= meta.newFromVersion ? "new" : "old";
    const cfg = await env.CONFIG.get(`${app}:${e}.${gen}`);
    if (!cfg) return new Response(`no config ${e}.${gen}`, { status: 404 });

    return new Response(cfg, {
      headers: { "content-type": "application/json", "x-config-variant": `${e}.${gen}` },
    });
  },
};
