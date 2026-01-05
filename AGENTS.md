# TestPilot - Agent Guidelines

This file contains guidelines for agentic coding agents working on the TestPilot codebase.

## Project Overview

TestPilot is a TypeScript tool for automatically generating unit tests for JavaScript/TypeScript packages using Large Language Models (LLMs). The project analyzes code, generates test prompts, validates tests, and provides benchmarking capabilities.

## Build & Development Commands

### Core Commands
- `npm run build` - Compile TypeScript (src/ and benchmark/ directories)
- `npm run build:watch` - Compile with watch mode for development
- `npm run test` - Run all tests using ts-mocha
- `npm run autoformat` - Format code with Prettier
- `npm run autoformat:check` - Check code formatting

### Running Single Tests
Use ts-mocha with specific test file:
```bash
ts-mocha -p test/tsconfig.json test/test-generation.ts
ts-mocha -p test/tsconfig.json test/syntax.ts
```

### Benchmarking
- `npm run benchmark` - Run benchmarking with LLM API
- `npm run env` - Set up environment variables for LLM API

## Code Style Guidelines

### TypeScript Configuration
- Target: ES2018
- Module: NodeNext
- Strict mode enabled
- Source maps enabled
- Experimental decorators enabled
- Skip lib check for faster compilation

### Import Style
- Use ES6 import/export syntax consistently
- Import external libraries first, then internal modules
- Group related imports together
- Use default imports for external packages when available

```typescript
// External libraries
import axios from "axios";
import fs from "fs";
import { expect } from "chai";

// Internal modules
import { Codex } from "./codex";
import { ICompletionModel } from "./completionModel";
```

### Naming Conventions
- **Classes**: PascalCase (e.g., `TestGenerator`, `MochaValidator`)
- **Interfaces**: Prefix with `I` (e.g., `ICompletionModel`, `ITestInfo`)
- **Functions/Methods**: camelCase (e.g., `generateTests`, `validateTest`)
- **Variables**: camelCase (e.g., `testDir`, `generatedPrompts`)
- **Constants**: UPPER_SNAKE_CASE for static values
- **Types**: PascalCase for type aliases, descriptive names

### Error Handling
- Use try/catch blocks for async operations
- Implement proper cleanup in finally blocks
- Use console.error for error messages
- Exit with error code for critical failures
- Return error objects or status enums for validation

```typescript
try {
  const result = await operation();
  return result;
} catch (error) {
  console.error(`Operation failed: ${error.message}`);
  process.exit(1);
} finally {
  cleanup();
}
```

### Code Organization
- Export all public APIs from `src/index.ts`
- Use barrel exports for related functionality
- Keep classes focused on single responsibility
- Use dependency injection pattern for testability

### Testing Patterns
- Use Mocha as the test framework
- Use Chai for assertions (expect/should syntax)
- Set appropriate timeouts for LLM operations
- Use `dedent` for multi-line test code strings
- Clean up temporary files and directories

```typescript
describe("ComponentName", function () {
  this.timeout(10000); // For LLM operations

  it("should perform action", () => {
    expect(result).to.equal(expected);
  });
});
```

### Documentation
- Use JSDoc comments for all public APIs
- Include parameter types and return types
- Add usage examples for complex functions
- Document environment variable requirements

### File Structure
- `src/` - Main source code
- `test/` - Test files
- `typings/` - TypeScript definitions
- `benchmark/` - Benchmarking code
- `ql/` - CodeQL queries for analysis

### LLM Integration
- Handle API endpoints and authentication via environment variables
- Implement retry logic for failed requests
- Use temperature parameters for controlling randomness
- Trim completions to remove unwanted text

### Performance Considerations
- Use performance hooks for timing measurements
- Implement caching for expensive operations
- Use streaming for large responses when possible
- Clean up resources properly

## Environment Setup

Required environment variables:
- `TESTPILOT_LLM_API_ENDPOINT` - LLM API endpoint URL
- `TESTPILOT_LLM_AUTH_HEADERS` - JSON string with authentication headers

## Dependencies

Key external dependencies:
- `axios` - HTTP client for LLM API calls
- `espree` - JavaScript/TypeScript parser
- `estraverse` - AST traversal
- `mocha` - Test framework
- `chai` - Assertion library
- `prettier` - Code formatting
- `typescript` - TypeScript compiler

## Common Patterns

### Prompt Generation
- Use the `Prompt` class for structured prompt creation
- Include function signatures, bodies, and documentation
- Add relevant code snippets for context
- Handle retry logic with error information

### Test Validation
- Use `TestValidator` interface for different validation strategies
- Implement status reporting (PASSED, FAILED, ERROR)
- Collect detailed failure information
- Support multiple test frameworks

### API Exploration
- Parse AST to find exported functions
- Extract JSDoc comments and type information
- Handle different module systems (CommonJS, ES modules)
- Generate comprehensive API descriptors

## Quality Assurance

Always run these commands before submitting changes:
1. `npm run autoformat:check` - Verify code formatting
2. `npm run build` - Ensure compilation succeeds
3. `npm run test` - Run all tests
4. Check for TypeScript strict mode compliance

## Debugging

- Use source maps for debugging compiled code
- Enable verbose logging for LLM API calls
- Check temporary directories for generated test files
- Use CodeQL queries for analyzing test generation results
