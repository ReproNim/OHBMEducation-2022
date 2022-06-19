import os, shutil
from pathlib import Path


def select_subjects(group):
    """reading file with the selected subjects"""
    group_formatted = f"{int(group):02d}"
    selections_file = Path(os.path.dirname(__file__)) / "../Exercise/Groups/" / f"Group_{group_formatted}"
    with selections_file.open() as f:
        selected = f.readlines()
    selected_sub = [el.rstrip() for el in selected[1:]]
    return selected_sub


def participate_file_update(dirname, selected_sub):
    """ updating particpants.tsv file """
    participant_file = Path(dirname) / "participants.tsv"
    participant_orig = Path(dirname) / "participants_orig.tsv"
    participant_file.rename(participant_orig)

    # reading an original list of the participants
    with participant_orig.open() as f:
        all_lines = f.readlines()
    os.remove(participant_orig)

    # removing most of the lines from the list
    selected_lines = []
    for el in all_lines:
        if el.startswith("sub-"):
            subj = el.split("\t")[0]
            if subj in selected_sub:
                selected_lines.append(el)
        else:
            selected_lines.append(el)

    # saving the subset of the lines
    with participant_file.open("w") as f:
        f.writelines(selected_lines)


def main(dirname, group):
    selected_sub = select_subjects(group)
    # removing directories
    dirs_all = os.listdir(dirname)
    for dir in dirs_all:
        if dir.startswith("sub-") and dir not in selected_sub:
            shutil.rmtree(Path(dirname) / dir)

    # removing additional files
    os.remove(Path(dirname) / "nidm.ttl")
    os.remove(Path(dirname) / "demographics.csv")

    # updating participant file
    participate_file_update(dirname, selected_sub)


if __name__ == '__main__':
    from argparse import ArgumentParser, RawTextHelpFormatter
    parser = ArgumentParser(description=__doc__,
                            formatter_class=RawTextHelpFormatter)
    parser.add_argument("-g", dest="group",
                        help="group id")
    parser.add_argument("-d", dest="data_dir",
                        help="path to the data",
                        default="/home/jovyan/my_data/my_ds001907-EDU")

    args = parser.parse_args()
    main(dirname=args.data_dir, group=args.group)


