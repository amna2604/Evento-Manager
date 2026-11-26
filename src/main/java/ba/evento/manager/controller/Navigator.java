package ba.evento.manager.controller;

public final class Navigator {

    public enum View {
        HOME("DashboardView", "Početna"),
        PROMOTIONS("PromotionsView", "Promocije"),
        PROMOTERS("PromotersView", "Promoteri"),
        STOCK("StockView", "Zalihe i oprema"),
        REPORTS("ReportsView", "Izvještaji"),
        SETTINGS("SettingsView", "Postavke");

        private final String fxml;
        private final String title;

        View(String fxml, String title) {
            this.fxml = fxml;
            this.title = title;
        }

        public String fxml() {
            return fxml;
        }

        public String title() {
            return title;
        }
    }

    private static MainController main;

    private Navigator() {
    }


    static void register(MainController controller) {
        main = controller;
    }


    public static void go(View view) {
        main.show(view);
    }
}