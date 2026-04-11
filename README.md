# SearXNG Docker Template for Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/6Qhjrg?referralCode=KKAfTD)

A ready-to-deploy [SearXNG](https://github.com/searxng/searxng) metasearch engine template for [Railway](https://railway.app). Get your own privacy-focused search engine running in minutes! Perfect for AI agents, FlowiseAI, n8n workflows, and any application needing web search capabilities.

## 🔍 About SearXNG

SearXNG is a free internet metasearch engine that aggregates results from more than 70 search services. It's designed to provide:

- **Privacy Protection**: No tracking, no data collection, no user profiling
- **Ad-Free Experience**: Clean search results without advertisements
- **Multiple Sources**: Combines results from Google, Bing, DuckDuckGo, and many more
- **AI-Ready**: JSON API perfect for AI agents, chatbots, and automation workflows
- **Open Source**: Fully transparent and community-driven
- **Customizable**: Configure which search engines to use and how results are displayed

## ✨ Features & Benefits of This Railway Template

### 🤖 AI-Optimized & Ready
- **AI Integration Ready**: Perfect backend for AI agents, chatbots, and automation tools
- **FlowiseAI Compatible**: Easy integration with FlowiseAI workflows for intelligent search
- **n8n Ready**: Seamless connection with n8n automation workflows
- **API Access**: JSON responses available for programmatic access
- **No API Keys Required**: Free alternative to Google Search API, Bing API, etc.

### 🚀 One-Click Deployment
- Deploy SearXNG instantly to Railway with zero configuration
- Automatic HTTPS and domain provisioning
- No Docker knowledge required

### ⚙️ Environment-Driven Configuration
- **Customizable Settings**: Override default configurations using environment variables
- **Scalable Performance**: Adjust worker count and threads based on your needs
- **Security**: Set custom secret keys for enhanced security

### 🔧 Optimized for Railway
- **Railway Integration**: Automatically detects Railway's `PORT` environment variable
- **Dynamic Base URL**: Configures itself based on Railway's provided domain
- **Volume Mount Compatible**: Works seamlessly with Railway's volume mounts
- **Persistent Configuration**: Custom settings persist across deployments

### 🛡️ Security & Privacy
- **Rate Limiting**: Built-in protection against abuse (configurable)
- **No Data Retention**: Search queries are not logged or stored
- **Secret Key Management**: Secure session handling with customizable keys

## 🚀 How to Use This Template

### Option 1: One-Click Deployment (Recommended)

1. **Click the Deploy Button** above
2. **Connect Your GitHub**: Railway will fork this template to your account
3. **Deploy**: Railway automatically builds and deploys your SearXNG instance
4. **Access**: Use the provided Railway domain to access your search engine

### Option 2: Add this template to your current project

1. **Create** Select Template
2. **Search** SearXNG (w/Official Image) and click on it.
3. **Deploy**: Railway will automatically detect and deploy it to your project.

### Option 3: Local Development

```bash
# Clone the repository
git clone <your-fork-url>
cd searxng-docker

# Start with docker-compose
docker-compose up -d

# Access at http://localhost:8080
```

## Example Screenshots

**SearXNG homepage**
![SearXNG homepage!](https://zyugzloemocjcxmspsso.supabase.co/storage/v1/object/public/static-assets//searxng-3.png "SearXNG homepage")

**SearXNG search**
![SearXNG search!](https://zyugzloemocjcxmspsso.supabase.co/storage/v1/object/public/static-assets//searxng-1.png "SearXNG search")

**SearXNG image search**
![SearXNG image search!](https://zyugzloemocjcxmspsso.supabase.co/storage/v1/object/public/static-assets//searxng-2.png "SearXNG image search")

**Hook up SearXNG to n8n and start automating your searches**
![SearXNG image search!](https://zyugzloemocjcxmspsso.supabase.co/storage/v1/object/public/static-assets//searxng-4.png "Hook up SearXNG to n8n and start automating your searches")

## ⚙️ Configuration

### Environment Variables

You can customize your SearXNG instance using these environment variables in Railway:

| Variable | Description | Default |
|----------|-------------|---------|
| `SEARXNG_SECRET_KEY` | Secret key for secure sessions | Auto-generated |
| `SEARXNG_BASE_URL` | Base URL of your instance | Railway domain |
| `SEARXNG_UWSGI_WORKERS` | Number of worker processes | 4 |
| `SEARXNG_UWSGI_THREADS` | Threads per worker | 4 |
| `PORT` | Port to listen on | 8080 (auto-set by Railway) |

### Setting Environment Variables in Railway

1. Go to your Railway project dashboard
2. Click on your service
3. Navigate to **Variables** tab
4. Add your custom environment variables
5. Redeploy if necessary

### Custom Configuration Files

The template includes these configuration files in the `searxng/` directory:

- **`settings.yml`**: Main SearXNG configuration (search engines, UI settings)
- **`limiter.toml`**: Rate limiting configuration
- **`uwsgi.ini`**: Auto-generated WSGI server configuration

You can modify these files and redeploy to customize your search engine behavior.

## 🤖 AI Integration Guide

### FlowiseAI Integration

1. **Deploy** your SearXNG instance using the one-click button above
2. **Get your Railway URL** (e.g., `https://your-app.railway.app`)
3. **In FlowiseAI**:
   - Use the **HTTP Request** node
   - Set URL to: `https://your-app.railway.app/search?q={query}&format=json`
   - Method: `GET`
   - Use the JSON response in your AI workflows

### n8n Integration

1. **Add HTTP Request Node** in your n8n workflow
2. **Configure the request**:
   - URL: `https://your-app.railway.app/search`
   - Method: `GET` 
   - Parameters:
     - `q`: Your search query
     - `format`: `json`
     - `categories`: `general` (optional)
3. **Process the results** using n8n's data transformation nodes

### API Usage Examples

**Basic Search:**
```bash
curl "https://your-app.railway.app/search?q=artificial+intelligence&format=json"
```

**Search with Category:**
```bash
curl "https://your-app.railway.app/search?q=machine+learning&format=json&categories=general,it"
```

**Image Search:**
```bash
curl "https://your-app.railway.app/search?q=robots&format=json&categories=images"
```

### Response Format
```json
{
  "query": "artificial intelligence",
  "number_of_results": 25,
  "results": [
    {
      "title": "Artificial Intelligence - Wikipedia",
      "url": "https://en.wikipedia.org/wiki/Artificial_intelligence",
      "content": "Artificial intelligence (AI) is intelligence demonstrated by machines...",
      "engine": "google"
    }
  ]
}
```

## 🔧 Advanced Usage

### Scaling Your Instance

For high-traffic usage, adjust these environment variables:

```env
SEARXNG_UWSGI_WORKERS=8    # Increase workers for more concurrent requests
SEARXNG_UWSGI_THREADS=6    # Increase threads per worker
```

### Security Hardening

1. **Set a Custom Secret Key**:
   ```env
   SEARXNG_SECRET_KEY=your-super-secret-key-here
   ```

2. **Configure Rate Limiting**: Edit `searxng/limiter.toml` to adjust rate limits

3. **Disable Debug Mode**: Edit `searxng/settings.yml` and set `debug: false`

## 🎨 Oryks Custom Theme

This deployment uses the **Oryks** custom theme — a minimalist, privacy-first design that replaces the default SearXNG appearance with:

- Off-white background (`#f4f5f4`) with white panels
- Muted green accent (`#2f6f4e`) for links, buttons, and highlights
- System font stack — no web fonts
- Hard edges (no border-radius, no drop shadows)
- Compact typography and clean result layout
- Full dark-mode support (respects browser preference via SearXNG's `theme-dark` / `theme-black` class)

### Theme Files

```
searxng/themes/oryks/
├── theme.toml              # Theme metadata
├── static/
│   ├── css/oryks.css       # All Oryks styles
│   └── img/oryks.png       # Logo (auto-downloaded from oryks.org at build time)
└── templates/
    ├── base.html           # Base layout (injects oryks.css, keeps all SearXNG blocks)
    ├── index.html          # Homepage — shows Oryks logo above the search form
    └── search.html         # Search-bar header on results pages — shows Oryks logo
```

The `Dockerfile` clones the upstream `simple` theme into `oryks/` at build time, rewrites all intra-theme template paths, then overlays the three template overrides above. This keeps every other SearXNG page (preferences, about, stats, …) fully functional without needing to copy every template.

### Replacing the Logo

1. Put your new logo at `searxng/themes/oryks/static/img/oryks.png` (or any web-accessible URL).
2. If serving from a URL, update the `RUN wget …` line in `Dockerfile` to point at your URL.
3. Rebuild and redeploy — the logo is automatically shown at 40 px height in the search bar and 80 px on the homepage.

**Changing the logo height** — edit `--oryks-logo-height` in `searxng/themes/oryks/static/css/oryks.css`:

```css
:root {
  --oryks-logo-height: 40px; /* header logo */
}
/* homepage logo is 2× that value by default */
```

### Adjusting Theme Colours

All design tokens live in the `:root` block at the top of `oryks.css`:

```css
:root {
  --oryks-bg:          #f4f5f4;  /* page background  */
  --oryks-panel:       #ffffff;  /* card / panel bg  */
  --oryks-text:        #1f2328;  /* body text        */
  --oryks-muted:       #57606a;  /* secondary text   */
  --oryks-border:      #d0d7de;  /* borders          */
  --oryks-accent:      #2f6f4e;  /* muted green      */
  --oryks-accent-dark: #24563c;  /* hover green      */
}
```

Change any value and redeploy; no template edits needed.

### Switching Back to the Default Theme

In `searxng/settings.yml`, change `default_theme: oryks` to `default_theme: simple`.

## 📁 Project Structure

```
searxng-docker/
├── Dockerfile              # Container configuration
├── docker-compose.yml      # Local development setup
├── entrypoint.sh           # Container startup script
├── README.md               # This file
└── searxng/                # SearXNG configuration
    ├── settings.yml        # Main SearXNG settings
    ├── limiter.toml        # Rate limiting configuration
    ├── uwsgi.ini           # Auto-generated WSGI config
    └── themes/oryks/       # Custom Oryks theme (CSS, logo, template overrides)
```

## 🤝 Contributing

1. Fork this repository
2. Make your changes
3. Test locally with `docker-compose up`
4. Submit a pull request

## 📝 License

This template is open source. SearXNG itself is licensed under the GNU Affero General Public License v3.0.

## 🔗 Links

- [SearXNG Official Site](https://searxng.github.io/searxng/)
- [SearXNG Documentation](https://docs.searxng.org/)
- [Railway Documentation](https://docs.railway.app/)
- [SearXNG GitHub Repository](https://github.com/searxng/searxng)

---

**Happy Searching!** 🔍✨
