import marketsV4 from "./v4/staging/markets.json";
import walletConnect from "./wallet_connect";
import { APP } from "./config/localization/app";

export { TOOLTIPS } from "./config/localization/tooltip";
export {
  APP_STRING_KEYS,
  ERRORS_STRING_KEYS,
  WARNINGS_STRING_KEYS,
  TOKEN_MIGRATION_STRING_KEYS,
} from "./scripts/generated/app";
export { TOOLTIP_STRING_KEYS } from "./scripts/generated/tooltips";
export { APP_NATIVE } from "./config/localizations_native";
export { NOTIFICATIONS } from "./config/localization_notifications";
export { NOTIFICATIONS_STRING_KEYS } from "./scripts/generated/notifications";

export const MARKETS_V4 = marketsV4;
export const WALLET_CONNECT = walletConnect;

export type SupportedLocale = keyof typeof APP;
export const LOCALE_DATA = APP;
