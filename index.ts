import walletsV2Production from './config/prod/walletsV2.json';
import walletsV2Staging from './config/staging/walletsV2.json';
import countries from './config/countries.json';
import marketsV3 from './config/markets.json';
import marketsV4 from './v4/staging/markets.json';
import versionIos from './config/version_ios.json';
import walletConnect from './wallet_connect';
import { APP } from './config/localization/app';

export { TOOLTIPS } from './config/localization/tooltip';
export  { APP_STRING_KEYS, ERRORS_STRING_KEYS, WARNINGS_STRING_KEYS } from './scripts/generated/app';
export  { TOOLTIP_STRING_KEYS } from './scripts/generated/tooltips';
export { APP_NATIVE } from './config/localizations_native';
export { NOTIFICATIONS} from './config/localization_notifications';

export const WALLETS_V2_PRODUCTION = walletsV2Production;
export const WALLETS_V2_STAGING = walletsV2Staging;
export const COUNTRIES = countries;
export const MARKETS_V3 = marketsV3;
export const MARKETS_V4 = marketsV4;
export const VERSION_IOS = versionIos;
export const WALLET_CONNECT = walletConnect;

export type SupportedLocale = keyof typeof APP;
export const LOCALE_DATA = APP;
