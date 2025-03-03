/**
 * We use mjs extension as constants in this file is shared with the build script
 * and we use `node --eval` to extract the constants.
 */
export const assetBaseUrl = "/custom-folder/";
export const imageBaseUrl = "/custom-folder/";

/**
 * @type {import("@webstudio-is/image").ImageLoader}
 */
export const imageLoader = ({ src }) => {
  return assetBaseUrl + src;
};
