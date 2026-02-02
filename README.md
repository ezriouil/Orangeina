# 🍊 Orangina (Berkania)

**Local Orange Marketplace Platform** — A marketplace feed app that connects users with local orange sellers in a simple, transparent, and community-driven way.

---

## 📱 User Experience App

Browse local sellers, compare prices, and order fresh oranges directly from your community.

### Features

| Feature | Description |
|---------|-------------|
| 🛒 **Marketplace Feed** | Browse local sellers in a dynamic feed |
| 📍 **Map-Based Discovery** | Explore nearby sellers through an interactive map |
| ⭐ **Ratings & Reviews** | Check seller ratings and reviews for trust |
| ⚡ **Simple Ordering** | Fast and easy ordering experience |
| 🤝 **Buyer-Seller Connection** | One platform connecting buyers and sellers |
| 💰 **Price Comparison** | Compare prices and offers from different sellers |
| 🔍 **Seller Search** | Find sellers by location or preferences |
| 📦 **Order Tracking** | Track your orders in real time |
| 💬 **Direct Communication** | Chat with sellers directly |
| ❤️ **Favorites** | Save your favorite sellers for quick access |
| 🔔 **Notifications** | Get alerts for new sellers and special offers |
| 📸 **Product Photos** | View high-quality images of fresh oranges |
| 💳 **Secure Payments** | Multiple payment options with secure checkout |
| 📊 **Order History** | View past purchases and reorder easily |

### Problems Solved

| Before ❌ | After ✅ |
|-----------|----------|
| Hard to find local sellers | Easy seller discovery |
| Unclear prices | Price comparison |
| No way to verify quality | Ratings for trust |
| Limited transparency | Transparent marketplace |
| — | Community-driven experience |

---

## 🏪 Seller Experience App

Orangina helps local sellers and farmers go digital. Create a professional account, list products, and receive orders through a live marketplace feed.

### Features

| Feature | Description |
|---------|-------------|
| 📦 **Real-Time Order Tracking** | Track orders in real time |
| ⭐ **Customer Reviews Management** | Manage customer reviews easily |
| 🔘 **Online/Offline Switch** | Control when you appear on the map |
| 🛍️ **Product Listing** | Create and manage product listings quickly |
| 💼 **Professional Account** | Set up a seller profile easily |
| 📍 **Location-Based Marketplace** | Appear on map for local customers |
| 📊 **Order Management** | View and manage all incoming orders |
| 💰 **Sales Analytics** | Track sales performance and revenue |
| 📱 **Live Marketplace Feed** | Receive orders through real-time feed |
| 🔔 **Order Notifications** | Get instant alerts for new orders |
| 📸 **Product Photos** | Upload high-quality product images |
| 💬 **Customer Communication** | Chat with customers directly |
| 📈 **Performance Dashboard** | Monitor your business metrics |
| 🌍 **Multi-Language Support** | Reach customers in their language |

### Problems Solved

| Before ❌ | After ✅ |
|-----------|----------|
| Limited digital presence | Easy digital setup |
| Hard to reach customers | Live marketplace access |
| Manual order management | Real-time order tracking |
| No visibility control | Full control over visibility |
| — | Streamlined operations |

---

## 🛠 Tech Stack

| Category | Technology |
|----------|------------|
| **Framework** | Flutter |
| **State Management** | flutter_bloc (Cubit) |
| **Backend** | Firebase (Auth, Firestore, Storage, Crashlytics) |
| **Navigation** | go_router |
| **DI** | get_it |
| **Maps** | google_maps_flutter, geolocator |
| **Localization** | flutter_localization |
| **Local Storage** | get_storage |
| **Network** | http, connectivity_plus |

---

## 📂 Project Structure

```
lib/
├── data/
├── domain/
├── presentation/
│   ├── auth/           # login, register, forget_password
│   ├── be_vendor/      # Seller onboarding
│   ├── home/
│   ├── notification/
│   ├── on_boarding/
│   ├── settings/
│   ├── vendor_details/
│   ├── vendor_new_order/
│   ├── vendor_orders/
│   └── wishlist/
├── utils/
└── main.dart
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.3.4 <4.0.0`
- Firebase project configured
- Google Maps API key (Android & iOS)

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd berkania

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Firebase Setup

1. Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
2. Configure Firebase Auth, Firestore, and Storage
3. Enable required Firebase services

---

## 📸 Branding

| Asset | URL |
|-------|-----|
| Logo | [Orangina Logo](https://res.cloudinary.com/dwcnliksx/image/upload/v1757004760/orangeina_logo_jfvoyv.png) |
| Client App Cover | [Client Cover](https://res.cloudinary.com/dwcnliksx/image/upload/v1766516103/thumb-orang_hlitbk.png) |
| Vendor App Cover | [Vendor Cover](https://res.cloudinary.com/dwcnliksx/image/upload/v1766526164/Vendor_4k_cjwolh.png) |

---

## 📄 License

This project is private. All rights reserved.
