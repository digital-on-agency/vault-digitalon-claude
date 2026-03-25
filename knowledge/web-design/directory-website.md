<!-- ultimo aggiornamento: 2026-03-21 -->

# Directory Website with GeoDirectory Plugin

## Overview

[GeoDirectory Documentation](https://wpgeodirectory.com/docs-v2)

Setting up a directory website on WordPress using the **GeoDirectory** plugin with **Elementor PRO** for design and layout.

## Setup

### Pre-installation Checklist

- **A WordPress Website:** self-hosted WordPress installation on a domain
- **Elementor Page Builder:** free Elementor plugin from WordPress repository
- **A Theme:** minimalist theme recommended (Hello or Astra)
- **Map API Key (Optional):** Google Maps API key, or use OpenStreetMap (free, no key needed)

### Install Plugins

From WordPress dashboard → **Plugins > Add New**:
1. Search and install **Elementor**, then **Activate**
2. Search and install **GeoDirectory**, then **Activate**

### GeoDirectory Setup Wizard

After activation, the Setup Wizard launches:
1. **Choose Mapping System:** Google Maps or OpenStreetMap
2. **Set Default City:** primary location for your directory
3. **Add Extra Features:** UsersWP (user registration), Ninja Forms (contact forms)
4. **Add Dummy Data:** recommended for visualizing how the directory will look

## Configurazioni standard

### General Settings

Navigate to **GeoDirectory > Settings**:
- **General:** default location, currency, basic settings
- **Import/Export:** import existing businesses in CSV format

### Design with Elementor

- Edit pages with **"Edit with Elementor"**
- Use dedicated **GeoDirectory Widgets**: search bar, map, listing lists
- Build homepage with GeoDirectory widgets + Elementor elements

## Workflow

### Core Directory Pages

1. **Homepage:** prominent search bar (GeoDirectory Search widget), featured listings, map
2. **Places Page (GD Archive):** lists all directory entries, customize with Elementor theme builder
3. **Single Listing Page:** individual listing details (address, contact, photos, reviews, map)
4. **Add Listing Page:** front-end form for user-submitted entries
5. **User Profile Pages:** manage listings, view reviews, update info (via UsersWP)
