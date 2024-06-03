# How To Contribute

Every open source project thrives on the generous contributions of individuals who offer their time and expertise. HandBot is no different. To ensure a pleasant experience for all contributors, this project adheres to a Code of Conduct.

## Setting Things Up

1. **Fork the HandBot Repository**
   - Fork the [HandBot repository](https://github.com/emmvs/handbot) to your GitHub account.

2. **Clone Your Forked Repository**
   - Clone your forked repository to your computer:

     ```sh
     git clone https://github.com/<your-username>/handbot.git
     cd handbot
     ```

3. **Add a Remote for the Original Repository**
   - Add a remote to track the original repository:

     ```sh
     git remote add upstream https://github.com/emmvs/handbot.git
     ```

4. **Install Dependencies**
   - Ensure you have Bundler installed:

     ```sh
     gem install bundler
     ```

   - Install the required gems:

     ```sh
     bundle install
     ```

5. **Install Pre-Commit Hooks**
   - Install pre-commit hooks to ensure code quality:

     ```sh
     pre-commit install
     ```

## Finding Something to Do

- **Have an Idea?** Check if it's already on the issue tracker. If it is, comment on the issue to let us know you want to work on it. If it's not listed, create a new issue and assign it to yourself.

- **Writing Tests**: If you're looking for a place to start, writing tests is a great option. Tests help ensure the stability and functionality of the codebase.

- **Avoid Adding New Dependencies**: We prefer to keep the project lean. If you need to add new dependencies, please discuss this in an issue first and get approval from a maintainer.

## Instructions for Making a Code Change

1. **Create a New Branch**
   - Choose a descriptive branch name (lowercase, hyphen-separated, and a noun describing the change).

     ```sh
     git fetch upstream
     git checkout master
     git merge upstream/master
     git checkout -b your-branch-name
     ```

2. **Make Your Changes**
   - Make commits to your feature branch. Each commit should be self-contained with a descriptive message.

3. **Run Tests**
   - Ensure that your code passes all tests:

     ```sh
     rspec
     ```

4. **Document Your Code**
   - Follow the Rails conventions and ensure your code is well-documented.

5. **Push Your Changes**
   - Push your branch to your fork on GitHub:

     ```sh
     git push origin your-branch-name
     ```

6. **Create a Pull Request**
   - Go to your fork on GitHub, select your branch, and create a pull request with a descriptive comment explaining the purpose of the branch.

7. **Address Review Comments**
   - Respond to review comments by making new commits addressing the feedback.

## Checklist for Pull Requests

- Ensure all tests pass.
- Document all changes according to the project's standards.
- Add yourself to the AUTHORS.rst file in alphabetical order.
- Do not break backward compatibility.

## Resolving Merge Conflicts

If you encounter merge conflicts, resolve them as follows:

```sh
git checkout your-branch-name
git fetch upstream
git merge upstream/master

# Fix conflicts and ensure tests pass
git commit -a
git push origin your-branch-name
