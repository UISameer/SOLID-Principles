# SOLID-Principles
SOLID Principles in SWIFT

5 principles of Object Oriented Programming.

Single Responsibility Principle
Open Closed
Liskov’s Subsititution
Interface Segregation
Dependency Inversion

These principle solve bad architecture problems like:- 
Delicacy — A change in one place breaks unexpected parts, its difficult to trace if there is no good test coverage.
Immobility — A component is difficult to reuse in another project or use in multiple places of same project, because it has to many dependencies.
Irritable — Takes a lot of effort for change, because it affects several parts.

Quick Summary
Each an every class should have only one responsibility
Should not modify the existing class for change requirement, rather extent the class
Extending or Inheriting a child/derived class should not break any parent or base class functionality
The Interface or class API’s to client should have minimum information required by the client
Class A should not depend on Class B or vice versa, both should be losely coupled
