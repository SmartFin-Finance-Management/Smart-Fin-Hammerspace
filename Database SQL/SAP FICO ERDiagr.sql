CREATE TABLE `organizations` (
  `org_id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `type` varchar(100),
  `address` varchar(255),
  `contact_info` varchar(255)
);

CREATE TABLE `users` (
  `user_id` int PRIMARY KEY AUTO_INCREMENT,
  `org_id` int,
  `name` varchar(255),
  `email` varchar(255) UNIQUE,
  `password` varchar(255),
  `role` varchar(100)
);

CREATE TABLE `client` (
  `client_id` int PRIMARY KEY AUTO_INCREMENT,
  `org_id` int,
  `name` varchar(255),
  `contact_info` varchar(255)
);

CREATE TABLE `projects` (
  `project_id` int PRIMARY KEY AUTO_INCREMENT,
  `org_id` int,
  `client_id` int,
  `project_name` varchar(255),
  `start_date` date,
  `end_date` date,
  `status` varchar(255),
  `total_budget` decimal(18,2),
  `allocated_budget` decimal(18,2),
  `remaining_budget` decimal(18,2),
  `employee_budget` decimal(18,2),
  `technical_budget` decimal(18,2),
  `additional_budget` decimal(18,2),
  `actual_expenses` decimal(18,2)
);

CREATE TABLE `employees` (
  `employee_id` int PRIMARY KEY AUTO_INCREMENT,
  `org_id` int,
  `name` varchar(255),
  `email` varchar(255) UNIQUE,
  `role` varchar(100),
  `employee_type` varchar(100),
  `experience` int,
  `lpa` decimal(18,2),
  `hourly_rate` decimal(18,2),
  `project_id` int,
  `project_manager_id` int,
  `attendance` json
);

CREATE TABLE `financial_transactions` (
  `transaction_id` int PRIMARY KEY AUTO_INCREMENT,
  `project_id` int,
  `client_id` int,
  `finance_user_id` int,
  `invoice_number` varchar(255) UNIQUE,
  `amount` decimal(18,2),
  `status` varchar(100),
  `transaction_date` date,
  `bank_name` varchar(100),
  `bank_account_no` varchar(100),
  `bank_payee_name` varchar(100),
  `bank_ifsc` varchar(100)
);

ALTER TABLE `users` ADD FOREIGN KEY (`org_id`) REFERENCES `organizations` (`org_id`);

ALTER TABLE `client` ADD FOREIGN KEY (`org_id`) REFERENCES `organizations` (`org_id`);

ALTER TABLE `projects` ADD FOREIGN KEY (`org_id`) REFERENCES `organizations` (`org_id`);

ALTER TABLE `projects` ADD FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`);

ALTER TABLE `employees` ADD FOREIGN KEY (`org_id`) REFERENCES `organizations` (`org_id`);

ALTER TABLE `employees` ADD FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`);

ALTER TABLE `employees` ADD FOREIGN KEY (`project_manager_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `financial_transactions` ADD FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`);

ALTER TABLE `financial_transactions` ADD FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`);

ALTER TABLE `financial_transactions` ADD FOREIGN KEY (`finance_user_id`) REFERENCES `users` (`user_id`);
