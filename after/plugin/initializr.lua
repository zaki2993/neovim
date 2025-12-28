local status, spring = pcall(require, "spring-initializr")
if not status then return end

spring.setup({
    -- Defaults (you can change these if you want)
    default_java_version = "17",
    default_language = "java",
    default_boot_version = "3.2.0",
})
