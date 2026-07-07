package model;

import java.util.Locale;

public class ChatAssistant {
    public String replyTo(String message) {
        if (message == null || message.trim().isEmpty()) {
            return "Please type a question about products, orders, returns, cancellations, payment, or delivery.";
        }

        String text = message.toLowerCase(Locale.ENGLISH);

        if (containsAny(text, "return", "refund", "exchange")) {
            return "Clothes can be returned within 7 days if unused. Books and stationery are not returnable unless damaged.";
        }
        if (containsAny(text, "cancel", "cancellation")) {
            return "Open Order History, choose the order, and cancel it before it is shipped.";
        }
        if (containsAny(text, "order", "history", "track", "status")) {
            return "You can view your orders from the Orders page after logging in.";
        }
        if (containsAny(text, "cart", "add", "quantity")) {
            return "Browse Products, click Add to Cart, then review quantities from the Cart page.";
        }
        if (containsAny(text, "product", "category", "search", "stock")) {
            return "Use the Products page to search by name, filter by category, check stock, and sort by price.";
        }
        if (containsAny(text, "payment", "pay", "checkout")) {
            return "Go to Checkout from your cart, confirm the details, and place the order.";
        }
        if (containsAny(text, "delivery", "shipping", "ship")) {
            return "Delivery details are confirmed during checkout. Order status can be checked from Order History.";
        }
        if (containsAny(text, "login", "register", "account")) {
            return "Use Login or Register from the navigation bar to manage your NexCart account.";
        }

        return "I can help with products, carts, orders, returns, cancellations, checkout, delivery, and accounts.";
    }

    private boolean containsAny(String text, String... keywords) {
        for (String keyword : keywords) {
            if (text.contains(keyword)) {
                return true;
            }
        }
        return false;
    }
}
