local lint_ok, lint = pcall(require, "lint")
lint.linters_by_ft = {
	markdown = { "vale" },
	json = { "jsonlint" },
	typescript = { "eslint_d" },
	javascript = { "eslint_d" },
}
