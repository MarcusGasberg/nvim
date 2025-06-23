# Copilot Instructions

## About This Configuration
This is a Neovim configuration that uses modern Lua-based plugins and integrations.

## Key Components
- **Plugin Manager**: Lazy.nvim for efficient plugin management
- **AI Integration**: Avante.nvim with Copilot provider using Claude Sonnet 4 model
- **MCP Integration**: MCPHub for Model Context Protocol server management
- **Language Support**: TreeSitter for syntax highlighting and parsing

## Development Guidelines
- Follow Lua best practices for Neovim configuration
- Use lazy loading where appropriate to maintain startup performance
- Maintain compatibility with both regular Neovim and VSCode Neovim extension
- Keep configurations modular and well-organized

## File Structure
- `lua/plugins/` - Plugin configurations
- `lua/config/` - Core Neovim settings
- `ftplugin/` - Filetype-specific configurations
- `my-snippets/` - Custom code snippets

## When Helping with This Config
- Respect existing plugin choices and configuration patterns
- Use proper Lua syntax and Neovim API conventions
- Consider performance implications of any changes
- Maintain backwards compatibility where possible
- Follow the established file organization structure
