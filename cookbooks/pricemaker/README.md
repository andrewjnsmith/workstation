## Pricemaker Workstation Default Setup

To install these scripts you'll need Xcode, the `soloist` gem, the [`pivotal_workstation` scripts](http://github.com/pivotal/pivotal_workstation) and the [`dmg` scripts](http://github.com/opscode-cookbooks/dmg).

Install soloist via

```bash
$ gem install soloist
```

If `git` is already on the machine you can just clone this entire repo (since it submodules the depencencies)

```bash
$ git clone http://github.com/pricemaker/workstation.git workstation
$ cd workstation
$ git submodule update --init
```

Failing that get a zip of this repo and each of the sub repositories and go from there.

Once you have all the required files just `cd` to the root directory (where the `)

```bash 
$ soloist
```