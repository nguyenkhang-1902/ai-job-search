# Interview Preparation Guide

<!-- SETUP: STAR examples are personalized by running /setup based on your actual experience -->

## STAR Format

Structure answers as: **Situation** (context), **Task** (your responsibility), **Action** (what you did), **Result** (outcome).

Keep answers to 1-2 minutes. Be specific. End with what you learned or would do differently.

## Ready-Made STAR Examples

<!-- Add more STAR examples as needed. Aim for 4-6 covering different competencies. -->

### Real-time Recruitment CDC Pipeline (data engineering, fault tolerance)
**Source:** CV - Independent Project, Mar-Apr 2026
**What happened:** Built a real-time Kappa Architecture streaming pipeline (Kafka + Spark, orchestrated via Airflow) with Spark Checkpointing and reconciliation layers to keep multi-source log sync under 30s latency and 99.9% consistency.
**Why it matters:** Answers questions about designing for reliability/fault tolerance, working with streaming data, and system design under latency constraints.
**S/T/A/R:**
- **Situation:** Personal portfolio project, designed greenfield from scratch. A source system (simulated with Cassandra) received high-frequency, timestamped candidate status logs, and the recruitment/ops team needed that data continuously synced to a relational warehouse (MySQL) to run real-time reporting and candidate reconciliation for hiring decisions.
- **Task:** Design a streaming architecture that keeps the MySQL copy in sync with low latency, and make it resilient to restarts and replay without corrupting downstream data.
- **Action:** Chose Kappa Architecture over Lambda to avoid maintaining parallel batch and speed layers, which risks logic drift between the two — with Kappa, everything is one continuous stream, so reprocessing history just means extending Kafka retention and replaying from an older offset through the same Spark Streaming code. Mid-build, hit Spark Streaming checkpoint corruption (triggered by storage disconnects and schema drift) that risked duplicate reads on restart. Fixed it with idempotent writes at the sink: replaced plain `INSERT`s with `UPSERT` (`ON DUPLICATE KEY UPDATE`) keyed on `candidate_uuid` + `updated_at`, so replayed/duplicate reads never produced duplicate rows.
- **Result:** Self-set design targets, verified with concrete measurement, not just claimed. Latency: measured event-time vs. processing-time skew per micro-batch via Spark UI metrics; under load testing, P95/P99 held at 15-25s against a <30s target. Consistency: built an Airflow-orchestrated reconciliation layer — an end-of-day DAG diffing row counts and checksums between the Cassandra source and MySQL sink; across multi-day tests on tens of thousands of records, data loss stayed under 0.1% (99.9%+ consistency).
- **Use for:** "Tell me about a time you designed for fault tolerance", "How do you handle data consistency in distributed systems?", "Walk me through a technical decision you made and why."

### Customer 360 Pipeline & AI Integration (ELT design, data resolution at scale)
**Source:** CV - Independent Project, Nov-Dec 2025
**What happened:** Built an end-to-end PySpark ELT pipeline on HDFS performing automated entity resolution and semantic clustering across 15k+ profiles, feeding a PostgreSQL warehouse and Power BI dashboards for risk assessment.
**Why it matters:** Answers questions about handling large/messy datasets, end-to-end pipeline ownership, and turning raw data into a business-facing output (dashboards).
**S/T/A/R:**
- **Situation:** Personal portfolio project building a Customer 360 system that unifies data from fragmented sources (CRM, POS, application logs). After landing 15,000+ raw profiles in a data lake, the data was dirty in two main ways: (1) cross-system desync — the same customer used a different email in CRM vs. a different email/phone in POS, so the system treated them as two people; (2) manual entry errors — inconsistent name formatting (accented vs. unaccented Vietnamese names) and messy addresses. Left unresolved, this would cause Marketing to send duplicate campaigns and Risk to misjudge customer behavior.
- **Task:** Design an entity resolution pipeline that consolidates these fragmented, dirty profiles into a trustworthy single customer view, without manually reviewing every record.
- **Action:** Built a hybrid 3-stage matching pipeline on PySpark: (1) deterministic matching — blocking/grouping on exact-match fields (national ID, phone/email), resolving ~60% of duplicates; (2) fuzzy matching — Jaro-Winkler and Levenshtein distance via PySpark UDFs to score name/address similarity, auto-merging clusters above a 0.85 threshold; (3) AI-powered semantic clustering for the remaining ~5-10% ambiguous cases (completely different names but matching address/behavior) — integrated a local LLM into the batch pipeline, prompted to act as a reconciliation expert and decide merge/no-merge with a reason, using PySpark data partitioning to push only ambiguous pairs to the LLM in small batches and avoid overload.
- **Result:** Clean data landed in a PostgreSQL warehouse feeding Power BI dashboards for Marketing and Risk (behavior tracking, segmentation, risk scoring). Consolidated 15k+ profiles into 11k+ unique customers, removing ~25% phantom duplicates; cut customer record lookup time from days to real-time; reduced duplicate/misdirected marketing sends to under 1%.
- **Use for:** "Tell me about a time you worked with messy/large-scale data", "How would you design an entity resolution system?", "Give an example of integrating an LLM into a data pipeline responsibly."

### Item Identification in Supermarket (applied ML, model optimization)
**Source:** CV - Independent Project / graduation thesis, Jan-Jul 2025
**What happened:** Curated and cleaned a product image dataset, then trained/deployed YOLO and DINOv2 models, applying mathematical optimization to balance inference speed against predictive accuracy.
**Why it matters:** Answers questions about ML model deployment trade-offs, data quality work, and applying formal optimization methods to a practical constraint.
**S/T/A/R:**
- **Situation:** Graduation thesis (Mathematics and Computer Science, University of Science, VNU-HCM) — building an automatic product recognition system for a smart self-checkout counter. Three core technical challenges: (1) fine-grained, large-scale classification across hundreds/thousands of SKUs, many with near-identical packaging differing only by flavor or brand; (2) environmental noise — constantly changing lighting, shadows from hands, dented/deformed packaging; (3) a real-time constraint running on an edge device at the counter with limited CPU/GPU resources.
- **Task:** Design a recognition pipeline accurate enough to distinguish visually similar SKUs, robust to lighting/packaging noise, that runs in real time on constrained edge hardware, and that scales to new products without full retraining.
- **Action:** Designed a two-stage pipeline instead of an end-to-end YOLO classifier — pure YOLO classification hurt fine-grained accuracy and required a full retrain every time a new product was added. Stage 1 (localization): YOLO only detects and crops the product region from the background, without naming it. Stage 2 (feature extraction & matching): the crop goes through DINOv2 (Meta's self-supervised Vision Transformer) to extract an embedding, then Cosine Similarity/KNN matches it against a vector database of reference product embeddings — adding a new product only needs 1-2 sample images added to the database, no retraining (few-shot/zero-shot). Optimized the speed/accuracy trade-off by dropping DINOv2's input resolution to 224x224 (cuts the Transformer's compute, which scales with input size, while keeping core features) and quantizing the model from FP32 to FP16/INT8 via TensorRT for hardware speedup.
- **Result:** YOLO reached mAP@0.5 >92%; DINOv2+KNN reached >95% accuracy on the test set, including on crumpled packaging and varied lighting; the pipeline held a stable ~30 FPS, meeting the real-time requirement. Against an end-to-end YOLOv8 baseline (carrying >100 classes), the hybrid architecture beat it by 7% overall accuracy; when simulating a 10-new-product update, the baseline's error rate spiked while this system stayed accurate immediately thanks to vector matching instead of retraining.
- **Use for:** "Tell me about a machine learning system you designed end-to-end", "How do you balance accuracy vs. latency in a production ML system?", "Describe a technical trade-off you made and why."

### Stakeholder progress reporting (STEM Instructor)
**Source:** CV - Teky Academy, Jan 2023-Jan 2024
**What happened:** Designed educational roadmaps and shared data-driven progress reports with internal management to align stakeholder expectations while teaching Python and Robotics.
**Why it matters:** Answers questions about communication with non-technical stakeholders, teaching/mentoring, and translating technical work into progress reporting.
**S/T/A/R:**
- **Situation:** Needed to report progress regularly to two very different audiences: internal center management (monthly/end-of-course reports) and parents (weekly updates after each session). The challenge: STEM subjects like Python and Robotics are abstract — parents lacked the expertise to judge their child's actual progress, and management lacked structured data to evaluate teaching effectiveness or spot retention risk.
- **Task:** Make abstract technical progress legible to both a non-technical audience (parents) and a data-driven internal audience (management), without one report format satisfying neither.
- **Action:** Designed an age-appropriate educational roadmap, breaking complex Python logic and robotics control concepts into small, digestible modules matched to students' actual learning pace. Replaced subjective, felt-sense evaluation with systematic performance tracking: project milestone completion rate, logic-exercise scores, in-class engagement level, and structured notes recorded after every session.
- **Result:** 100% of assigned students completed and successfully defended their final tech project on schedule. Student retention held above 90%, among the center's best. Parent satisfaction (CSAT) rose noticeably, and management used the reporting structure to standardize how training quality was tracked across the center.
- **Use for:** "Tell me about a time you communicated technical work to a non-technical audience", "Describe a time you used data to track outcomes", "Tell me about mentoring or teaching experience."

## Common Tough Questions

### "Why did you leave [previous company]?"
> [PREPARE YOUR ANSWER - be honest, forward-looking, no negativity about former employer]

### "You don't have [specific skill/experience]."
> [PREPARE YOUR ANSWER - acknowledge the gap, bridge to adjacent experience, show willingness to learn]

### "Where do you see yourself in 5 years?"
> [PREPARE YOUR ANSWER - show ambition aligned with the role's growth path]

### "What's your biggest weakness?"
> [PREPARE YOUR ANSWER - genuine weakness with concrete mitigation strategy]

### "Why this company specifically?"
> Customize per company. Must reference: specific projects, company values, market position, or team structure. Never give a generic answer.

## Questions You Should Ask Interviewers

### About the Role
- "What does a typical week look like in this role?"
- "What would success look like in the first 6 months?"
- "What's the biggest challenge the team is facing right now?"

### About the Team
- "How big is the team, and how do you divide work?"
- "What does the development/project lifecycle look like, from idea to production?"
- "How do you onboard new team members?"

### About Tech & Growth
- "What's your current tech stack for [relevant area]?"
- "Is there room to grow into more architectural or strategic decisions?"
- "How does the team stay current with new tools and methods?"

### About Culture (use these to prevent disappointment)
- "How would you describe the team culture?"
- "What does professional development look like here?"
- "Is there flexibility for remote/hybrid work?"
- "What's the balance between development/new projects and maintenance work?"
- "How would you describe the leadership style in this team?"
- "What do people who thrive here have in common?"

## Phone/Video Interview Tips
- Have STAR examples written out (use this file)
- Keep a glass of water nearby
- Smile when speaking (it changes your tone)
- Ask for clarification if a question is vague
- It's OK to take 5 seconds to think before answering
- End with: "Is there anything else you'd like to know about my background?"

## After the Application (Best Practice)

### Follow-Up Etiquette
- **Don't call to "stand out"** or to learn more about the role post-submission - this risks a negative impression
- If the employer specified a timeline, respect it and wait
- If no timeline was given and significant time has passed (2+ weeks), a brief call to ask about status is acceptable
- If you have genuinely new, relevant information to share, a short follow-up is fine

### Thank-You Notes
- When you receive any update (interview invitation, rejection, or status update), send a brief thank-you message
- Express appreciation for their time and the process
- Keep it short (2-3 sentences)

## Roleplay Guidelines
When the user asks for interview practice:
1. Ask which role/company to simulate
2. Start with easy warm-up questions ("Tell me about yourself")
3. Progress to role-specific technical questions
4. Include 1-2 behavioral questions using the competencies from the job posting
5. End with a tough question or curveball
6. After each answer, give brief feedback: what worked, what to sharpen
7. Suggest which STAR example would work best for each question
