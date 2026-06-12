// Reads runtime environment variables injected by docker-entrypoint.sh
// Never import process.env here — values are not baked into the build

const runtimeConfig = window.__RUNTIME_CONFIG__ || {}

export const getConfig = (key) => {
  if (!(key in runtimeConfig)) {
    console.warn(`[runtimeConfig] Missing key: ${key}`)
  }
  return runtimeConfig[key]
}

export default runtimeConfig
