import jenkins.model.Jenkins

def thr = Thread.currentThread()
def build = thr?.executable

new_prs = build.getWorkspace().child('new-prs.txt').readToString().split(/(;|,|\n)/)
new_prs.each { pr_id ->
    pr_job = Jenkins.instance.getJob('libnacl').getJob('pr').getJob("${pr_id}").getJob('main-build')
    trigger = job.triggers.iterator().next().value
    repo = trigger.getRepository()
    pr = repo.getPullRequest(pr_id)
    repo.check(pr)
    pr = repo.pulls.get(pr_id)
    repo.helper.builds.build(pr, pr.author, 'Job Created. Start Initial Build')
}
