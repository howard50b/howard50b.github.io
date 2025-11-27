---
title: Metabolizing Machines
subtitle: Here is some extra detail about the post.
layout: default
date: 2025-11-26
keywords: ai, continual learning
published: false
---

Imagine an intelligent system that can operate endlessly, not just for minuites, but hours, or days, or even months, years, decades. What does it take to build such a system?

## Scenario 1: Curious Machines

Contrasts the LLM Daydreaming scenario where the learning is inward and retrospective.


## Scenario 2: AI Scientists

Limits to how much in-context learning can understand experimental feedback from (x, y) pairs ([Xingyou Song's tweet](https://x.com/XingyouSong/status/1979606835830170079?s=20) and [LLM fails to understand blackboxes paper](https://arxiv.org/abs/2505.17968)).


## Isn't It Just RL?

Answer: it is in its ultimate form but with a critical difference---a meta optimization loop that controls the metabolism. The challenge is to control the gain of information vs. forgetting ratio.


### Algorithm
1. Generate experiences/trajectories
2. Digest the experience
  - Write out a document/note (knowledge)
  - Refine or fill in the reasoning steps (skill)
  - Infer preferences (ToM)
3. Choose incorporation strategy
  - Parameter update: MLE, policy gradient, LoRA
  - Place in-context
  - Write into the data store for later retrieval
4. Choose compose the objectives:
  - Capability: current task performance / user preferences
  - Risk: forgetting / safety


## The Engineering Perspective

Continual Learning in the Pre-LM Era
- [Catastrophic Interference in Connectionist Networks: The Sequential Learning Problem](https://doi.org/10.1016/S0079-7421(08)60536-8)


Orthogonality / fast-slow learning / replay / memory augmentation / low rank update.

###### **Orthogonality.**
- EWC


###### **Fast-slow learning.**
The "two learning speeds" idea traces back to the Complementary Learning Systems (CLS) framework by McClelland, McNaughton & O’Reilly (1995). The hippocampus learns quickly---it can form new episodic associations after one or a few experiences---while the neocortex learns slowly, integrating information across many experiences to build stable, semantic knowledge.

###### **Replay.**
Idea: on-policy replay (re-digested data for replay).

###### **Memory augmentation.**
- RAG

###### **Low rank update.**
- RL
- LoRA

## Context Scaling

Where are we now? A study from METR ([Measuring AI Ability to Complete Long Tasks](https://metr.org/blog/2025-03-19-measuring-ai-ability-to-complete-long-tasks/)) suggests that the length of tasks AI can do is doubling every 7 months.


Context length growth.

Software rot.

Context rot.

Effective context (Lost in the Middle).


## Parametric Memory

- Bits of information per experience
- Bits per param (cite physics of LM)
- Low rank on-policy data


## Towards Machine Metabolism

Metabolism is about what to keep and what to lose. The difference between machines and living beings is that machines have full access to their own "body" and can hack it, roll it back, or replicate it as freely as they see fit.

To live is to fight against the increase of entropy.
The model is risen from a state of high entropy. Through training, the entropy minimization objective brings the model to a structured state.

A metabolizing machine is a system that continues to draw negative entropy from its environment.
This statement requires a few constraints. For such a system to make sense for humans, it must not degenerate.
A metabolizing machine can continue to lower the informational entropy of the data it draws from the environment, yet simultaneously regressing through overfitting.

Modern language models are not fully metabolizing machines either. They can draw negative entropy by accumulating


A common confusion may arise as lower entropy on the task examples does not necessarily mean good task performance, which is often observed in RLHF'd models. This is because task examples are only the surface form of the latents that generate them. In this regard, the entropy on thse latents should be lower and not the examples after learning from this distribution.




What guides the evolution?  Learning signal should come from the environment, and the model should decide itself what the signal is. It will necessarily produce systems that have very distinct characteristics. A model on a wearable device will evolve into a better model in that environment (aimoing for lower inference cost).

- Wake-Sleep Algorithm
- [Forward-Forward Algorithm and the mortal computer](https://arxiv.org/abs/2212.13345)



## Proposal

Tools of metabolism
- Digest: summarize / reformat (e.g., knowledge into synthetic wiki page)
- Algorithmic choice: LoRA / RL / SFT
- Archive information for later replay
- Archive information for later retrieval

Guided by self-defined reward conditioned on 1) experience and 2) meta information about the environment.


Setup $$N$$ agentic environments. The model needs to setup it's own learning target or context management strategy.


## Implications
Practical
- Safety

Philosophical
- Agency / free will
- Consciousness
- Wants

## Other Proposals

LLM Daydreaming envisons a process that continually samples from the model itself and collect relevant concepts for training. This proposal suggests that the issue is insufficient introspection.

While the metabolizing machine thesis does not presume where the information comes from, it's natural to imagine it is gathered from interation with the world.

Retrospective thinking is a way to ensure model's self-consistency---i.e., the model already has all the information within itself and the lacking bit is how they are connected, which does not emerge from typical gradient descent training.

## References
- What Is Life? The Physical Aspect of the Living Cell by Erwin Schrödinger
- [Welcome to the Era of Experience](https://storage.googleapis.com/deepmind-media/Era-of-Experience%20/The%20Era%20of%20Experience%20Paper.pdf)
- [The Unbearable Slowness of Being: Why do we live at 10 bits/s?](https://arxiv.org/abs/2408.10234)
- [LLM Daydreaming](https://gwern.net/ai-daydreaming)
- [The Continual Learning Problem](https://jessylin.com/2025/10/20/continual-learning/)
- [Self-Adapting Language Models](https://arxiv.org/abs/2506.10943)
- [Context Rot](https://research.trychroma.com/context-rot)
- [Recursive Language Models](https://alexzhang13.github.io/blog/2025/rlm/)
- [Physics of Language Models: Part 3.3, Knowledge Capacity Scaling Laws](https://arxiv.org/abs/2404.05405)
- [On-Policy Distillation](https://thinkingmachines.ai/blog/on-policy-distillation/#loss-function-reverse-kl)


## Citation
```
@article{chen2025metabolizing,
  title   = "The Metabolizing Machines",
  author  = "Chen, Howard",
  year    = "2025",
  month   = "November",
  url     = "https://howard50b.github.io/metabolizing-machines/"
}
```
