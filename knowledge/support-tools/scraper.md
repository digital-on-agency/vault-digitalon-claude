<!-- ultimo aggiornamento: 2026-03-21 -->

# Web Scraper

## Overview

Build web scrapers with Python using **BeautifulSoup** for HTML parsing and **Selenium** for browser automation.

### Requirements

- Python 3.10+
- pip3 24+
- beautifulsoup4 4.13+
- selenium (latest)

## Setup

### Selenium Installation

[Official Documentation](https://www.selenium.dev/documentation/webdriver/getting_started/install_library/)

```bash
pip install selenium
```

### Eight Basic Components

1. **Start session:** `driver = webdriver.Chrome()`
2. **Navigate:** `driver.get("https://example.com")`
3. **Get browser info:** `title = driver.title`
4. **Waiting strategy:** `driver.implicitly_wait(0.5)`
5. **Find element:** `driver.find_element(by=By.NAME, value="my-text")`
6. **Take action:** `text_box.send_keys("text")` / `button.click()`
7. **Get element info:** `text = element.text`
8. **End session:** `driver.quit()`

### Waiting Strategies

**Implicit waits** — global setting, wait for element location:
```python
driver.implicitly_wait(2)
```

**Explicit waits** — poll for specific condition:
```python
wait = WebDriverWait(driver, timeout=2)
wait.until(lambda _: revealed.is_displayed())
```

**Customization:**
```python
errors = [NoSuchElementException, ElementNotInteractableException]
wait = WebDriverWait(driver, timeout=2, poll_frequency=.2, ignored_exceptions=errors)
```

### Browser Interactions

```python
title = driver.title          # Get title
url = driver.current_url      # Get current URL
driver.get("https://...")     # Navigate
driver.back()                 # Back
driver.forward()              # Forward
```

## Configurazioni standard

### Proxy Setup

**Basic proxy:**
```python
options = webdriver.ChromeOptions()
options.add_argument(f"--proxy-server={PROXY}")
driver = webdriver.Chrome(options=options)
```

**Authenticated proxy (with Selenium Wire):**
```bash
pip install blinker==1.7.0 selenium-wire
```
```python
from seleniumwire import webdriver

proxy_url = f"http://{username}:{password}@{address}:{port}"
seleniumwire_options = {
    "proxy": {"http": proxy_url, "https": proxy_url},
}
driver = webdriver.Chrome(seleniumwire_options=seleniumwire_options, options=options)
```

**Rotating proxy:**
```python
import random
PROXIES = ["http://ip1:port", "http://ip2:port", ...]
proxy = random.choice(PROXIES)
```

**Best protocols:** HTTP/HTTPS for web scraping; SOCKS5 for non-HTTP traffic.

### Avoiding Bot Detection

#### 1. IP Rotation / Proxy
Use proxies as intermediary — server can't draw behavioral patterns.

#### 2. Disable Automation Flags
```python
options.add_argument("--disable-blink-features=AutomationControlled")
options.add_experimental_option("excludeSwitches", ["enable-automation"])
options.add_experimental_option("useAutomationExtension", False)
driver.execute_script("Object.defineProperty(navigator, 'webdriver', {get: () => undefined})")
```

#### 3. Rotate User Agents
```python
driver.execute_cdp_cmd("Network.setUserAgentOverride", {"userAgent": useragentarray[i]})
```

#### 4. Avoid Patterns
Randomize time frames, use waits, scroll slower, mimic human behavior:
```python
time.sleep(random.uniform(2, 5))
```

#### 5. Remove JavaScript Signature
Replace `cdc_` with another string in chromedriver binary using Vim:
```
:%s/cdc_/abc_/g
```

#### 6. Using Cookies
Login once, collect session cookies, reuse them to avoid repeated authentication.

#### 7. Follow the Page Flow
Click links, fill forms, navigate naturally like a human user.

#### 8. Browser Extension (uBlock Origin)
Block JavaScript challenges and CAPTCHAs from loading.

#### 9. Selenium Stealth Plugin
```bash
pip install selenium-stealth
```
Modifies Selenium defaults to mimic real browser fingerprints. Works against basic to moderate anti-bot measures. Limited against advanced systems like Cloudflare.

## Note e benchmark

- Free proxies are error-prone and often get blocked — use premium proxies for production
- How websites detect Selenium: checking `window.navigator.webdriver`, `$cdc_` variables, automation flags, browser fingerprinting, behavior pattern analysis
- Always use explicit waits over implicit waits for reliability
- For production scraping, consider dedicated scraping APIs (e.g., ZenRows) over raw Selenium
