# Search Queries for Job Scraper

<!-- SETUP: Customize these queries based on your skills, target roles, and location -->

## Search Sites

Primary (your market's job boards - scaffold one with `/add-portal`):
- **No Vietnam-market portal skill installed yet** - the framework's built-in portal CLIs (Jobindex, Jobbank, Jobdanmark, Jobnet) are Denmark-specific and don't apply here. Run `/add-portal` to scaffold one for a Vietnam board (e.g. ITviec, TopCV, VietnamWorks) when ready.
- **linkedin.com/jobs** - LinkedIn job listings (filter: Vietnam / Ho Chi Minh City, Binh Duong)

Secondary (company career pages via Google):
- Direct Google searches with `site:` filters for known target companies (none specified yet - broad search for now)

## Query Categories

Queries are grouped by priority. Each query should be combined with your location terms (Binh Duong, Ho Chi Minh City, Vietnam) where the site supports it.

### Priority 1: AI/ML Engineer / Data Scientist

These match your strongest and most desired career direction.

```
site:linkedin.com/jobs "AI Engineer" Vietnam
site:linkedin.com/jobs "Machine Learning Engineer" Vietnam
site:linkedin.com/jobs "Data Scientist" "Ho Chi Minh City"
site:linkedin.com/jobs "Data Scientist" fresher OR junior Vietnam
```

### Priority 2: Data Engineer

These match your domain expertise (secondary target role).

```
site:linkedin.com/jobs "Data Engineer" Vietnam
site:linkedin.com/jobs "Data Engineer" PySpark OR Airflow OR Kafka "Ho Chi Minh City"
site:linkedin.com/jobs "Big Data Engineer" Vietnam
```

### Priority 3: Adjacent Roles

Adjacent roles you could pivot into.

```
site:linkedin.com/jobs "Data Analyst" Power BI "Ho Chi Minh City"
site:linkedin.com/jobs "Computer Vision Engineer" Vietnam
site:linkedin.com/jobs "BI Engineer" Vietnam
```

### Priority 4: Broader Technical

Wider net for general technical roles.

```
site:linkedin.com/jobs Python developer "Ho Chi Minh City"
site:linkedin.com/jobs "Data Science Intern" OR "AI Intern" Vietnam
site:linkedin.com/jobs "backend developer" Python Vietnam
```

## Location Filter

When evaluating results, verify the job location is within reasonable commute distance from your home. Define acceptable areas:
- Binh Duong (home base - ideal)
- Ho Chi Minh City (acceptable - regular commute)
- Remote/hybrid roles for Vietnam-based companies (borderline - evaluate case by case)
- Anywhere requiring relocation outside Binh Duong / Ho Chi Minh City (too far - deal-breaker)

## Date Filter

Only include jobs posted within the last 14 days, or with an application deadline that has not yet passed. If a posting date cannot be determined, include it but flag as "date unknown".

## Adapting Queries

If the user specifies a focus area, select queries from the matching category and also generate 2-3 custom queries for that focus. For example:
- "/scrape [focus_area]" -> relevant category queries + custom focus-specific queries
