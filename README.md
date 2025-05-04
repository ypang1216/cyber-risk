# Cyber Risk Segmentation Platform

A web application for startup cyber risk segmentation and insurance recommendations, built with Astro and Svelte.

## Features

- **Risk Assessment Tool**: Interactive form to analyze your company's cyber risk profile
- **Risk Visualization**: Visual representation of different risk categories affecting your business
- **Insurance Recommendations**: Tailored cyber insurance coverage suggestions based on your risk profile
- **Security Recommendations**: Actionable steps to improve your security posture
- **Interactive Dashboards**: Data-driven insights about your organization's cyber risk posture

## Technology Stack

- **Frontend Framework**: [Astro](https://astro.build/) v5.7.10 with [Svelte](https://svelte.dev/) v5.28.2
- **Styling**: [Tailwind CSS](https://tailwindcss.com/) v3.4.17
- **Visual Effects**: [tsParticles](https://particles.js.org/) for interactive backgrounds
- **Containerization**: Docker & Docker Compose

## Components

The application includes several key components:

- **RiskAssessmentForm**: Interactive questionnaire for gathering company security information
- **RiskSegmentChart**: Data visualization for different risk categories
- **ParticlesBackground**: Dynamic, interactive background for enhanced user experience
- **Dashboard**: Centralized view of risk metrics and recommendations

## Development

### Prerequisites

- Node.js v18 or higher
- npm v8 or higher

### Local Development

1. Clone the repository
   ```bash
   git clone <repository-url>
   cd cyber-risk
   ```

2. Install dependencies
   ```bash
   npm install
   ```

3. Start the development server
   ```bash
   npm run dev
   ```

4. Open your browser and visit `http://localhost:4321`

### Building for Production

```bash
npm run build
```

The build output will be generated in the `dist/` directory.

### Preview Production Build

```bash
npm run preview
```

## Docker Deployment

### Using Docker Compose

1. Build and start the containers:
   ```bash
   docker-compose up -d
   ```

2. Access the application at `http://localhost:4321`

3. Stop the containers:
   ```bash
   docker-compose down
   ```

### Using Docker Directly

1. Build the Docker image:
   ```bash
   docker build -t cyber-risk-app .
   ```

2. Run the container:
   ```bash
   docker run -p 4321:4321 cyber-risk-app
   ```

## Project Structure

```
cyber-risk/
├── public/                # Static assets
├── src/
│   ├── components/        # Reusable UI components
│   │   └── svelte/        # Svelte components (ParticlesBackground, RiskAssessmentForm, etc.)
│   ├── data/              # Data files and models
│   ├── layouts/           # Page layouts
│   ├── pages/             # Application pages (index, dashboard, about)
│   │   └── api/           # API endpoints
│   └── styles/            # Global styles
├── astro.config.mjs       # Astro configuration
├── docker-compose.yml     # Docker Compose configuration
├── Dockerfile             # Docker build instructions
└── package.json           # Project dependencies
```

## Version Information

- Current Version: 0.0.1
- Last Updated: May 3, 2025

## License

[MIT](LICENSE)
